//
//  UberMapViewModel.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 07/10/25.
//

import SwiftUI
internal import Combine
import MapKit

@MainActor
class UberMapViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var rideState: RideState = .selectingDestination
    @Published var pickupLocation: String = "Current Location"
    @Published var destination: String = ""
    @Published var isSearchingDestination = false
    @Published var searchResults: [LocationSearchResult] = []
    @Published var selectedPickup: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090)
    @Published var selectedDestination: CLLocationCoordinate2D?
    @Published var route: MKRoute?
    @Published var estimatedTime: String = ""
    @Published var baseFare: Int = 0
    @Published var selectedRideOption: RideOption = .uberX
    @Published var camera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    // MARK: - Constants
    let drivers = [
        CLLocationCoordinate2D(latitude: 28.616, longitude: 77.210),
        CLLocationCoordinate2D(latitude: 28.618, longitude: 77.215),
        CLLocationCoordinate2D(latitude: 28.610, longitude: 77.205),
        CLLocationCoordinate2D(latitude: 28.612, longitude: 77.208),
        CLLocationCoordinate2D(latitude: 28.620, longitude: 77.212),
    ]
    
    let dummyLocations = [
        LocationSearchResult(name: "Connaught Place", subtitle: "New Delhi, Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.6315, longitude: 77.2167)),
        LocationSearchResult(name: "India Gate", subtitle: "Rajpath, New Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.6129, longitude: 77.2295)),
        LocationSearchResult(name: "Red Fort", subtitle: "Lal Qila, Chandni Chowk", coordinate: CLLocationCoordinate2D(latitude: 28.6562, longitude: 77.2410)),
        LocationSearchResult(name: "Lotus Temple", subtitle: "Bahapur, New Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.5535, longitude: 77.2588)),
        LocationSearchResult(name: "Qutub Minar", subtitle: "Mehrauli, New Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.5245, longitude: 77.1855)),
        LocationSearchResult(name: "Akshardham Temple", subtitle: "Pandav Nagar, New Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.6127, longitude: 77.2773)),
        LocationSearchResult(name: "Humayun's Tomb", subtitle: "Mathura Road, New Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.5933, longitude: 77.2507)),
        LocationSearchResult(name: "Chandni Chowk", subtitle: "Old Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.6506, longitude: 77.2334)),
    ]
    
    // MARK: - Computed Properties
    var estimatedPrice: String {
        calculatePrice(for: selectedRideOption)
    }
    
    // MARK: - Search Methods
    func updateSearchResults() {
        if !isSearchingDestination {
            searchResults = []
            return
        }
        
        if destination.isEmpty {
            searchResults = dummyLocations
        } else {
            searchResults = dummyLocations.filter { location in
                location.name.localizedCaseInsensitiveContains(destination) ||
                location.subtitle.localizedCaseInsensitiveContains(destination)
            }
        }
    }
    
    func selectDestination(_ result: LocationSearchResult) {
        destination = result.name
        selectedDestination = result.coordinate
        isSearchingDestination = false
        searchResults = []
        
        calculateRoute()
        updateCamera()
    }
    
    func handleDestinationChange() {
        updateSearchResults()
    }
    
    func handleSearchFocusChange(isFocused: Bool) {
        isSearchingDestination = isFocused
        if isFocused {
            updateSearchResults()
        } else if !isFocused && destination.isEmpty {
            searchResults = []
        }
    }
    
    func dismissSearch() {
        isSearchingDestination = false
    }
    
    // MARK: - Route Calculation
    func calculateRoute() {
        guard let destination = selectedDestination else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: selectedPickup))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else { return }
            
            Task { @MainActor in
                self.route = route
                
                // Calculate estimates
                let timeInterval = route.expectedTravelTime
                let hours = Int(timeInterval) / 3600
                let minutes = (Int(timeInterval) % 3600) / 60
                
                if hours > 0 {
                    self.estimatedTime = "\(hours)h \(minutes)m"
                } else {
                    self.estimatedTime = "\(minutes) min"
                }
                
                let distance = route.distance / 1000 // Convert to km
                let baseFareValue = 50
                let perKmRate = 12
                let estimatedFare = baseFareValue + Int(distance * Double(perKmRate))
                
                self.baseFare = estimatedFare
                self.rideState = .confirmingRide
            }
        }
    }
    
    // MARK: - Camera Methods
    func updateCamera() {
        guard let destination = selectedDestination else { return }
        
        let coordinates = [selectedPickup, destination]
        let lats = coordinates.map { $0.latitude }
        let longs = coordinates.map { $0.longitude }
        
        let minLat = lats.min()!
        let maxLat = lats.max()!
        let minLong = longs.min()!
        let maxLong = longs.max()!
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLong + maxLong) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLong - minLong) * 1.5
        )
        
        camera = .region(MKCoordinateRegion(center: center, span: span))
    }
    
    // MARK: - Price Calculation
    func calculatePrice(for option: RideOption) -> String {
        // Base fare structure
        let basePrice = 50 // Base pickup charge
        let minimumFare = 80 // Minimum fare regardless of distance
        
        guard baseFare > 0 else {
            return "₹--"
        }
        
        // Calculate distance-based fare with ride option multiplier
        var calculatedFare = Double(baseFare) * option.priceMultiplier
        
        // Apply surge pricing during peak hours (simulated)
        let hour = Calendar.current.component(.hour, from: Date())
        let isPeakHour = (hour >= 8 && hour <= 10) || (hour >= 17 && hour <= 20)
        
        if isPeakHour {
            let surgePricing = 1.3 // 30% surge
            calculatedFare *= surgePricing
        }
        
        // Apply minimum fare rule
        calculatedFare = max(calculatedFare, Double(minimumFare) * option.priceMultiplier)
        
        // Round to nearest 10 for cleaner pricing
        let roundedFare = (Int(calculatedFare) / 10) * 10
        
        // Apply platform fee (5% capped at ₹20)
        let platformFee = min(Int(Double(roundedFare) * 0.05), 20)
        
        // Calculate GST (5% on total)
        let subtotal = roundedFare + platformFee
        let gst = Int(Double(subtotal) * 0.05)
        
        // Final fare
        let finalFare = subtotal + gst
        
        return "₹\(finalFare)"
    }
    
    func selectRideOption(_ option: RideOption) {
        selectedRideOption = option
    }
    
    // MARK: - Ride Booking
    func bookRide() {
        rideState = .bookingRide
        
        // Simulate booking process
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
                rideState = .rideBooked
            }
        }
    }
    
    func cancelBooking() {
        rideState = .confirmingRide
    }
    
    func cancelRide() {
        rideState = .selectingDestination
        selectedDestination = nil
        destination = ""
        route = nil
        estimatedTime = ""
        baseFare = 0
        selectedRideOption = .uberX
        isSearchingDestination = false
        searchResults = []
        camera = .region(MKCoordinateRegion(
            center: selectedPickup,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
}

// MARK: - Supporting Models
enum RideOption: String, CaseIterable {
    case uberX = "UberX"
    case uberXL = "UberXL"
    case premier = "Premier"
    
    var subtitle: String {
        switch self {
        case .uberX: return "1 seat • Affordable rides"
        case .uberXL: return "2 seats • More space"
        case .premier: return "4 seats • Premium cars"
        }
    }
    
    var systemImage: String {
        switch self {
        case .uberX: return "motorcycle.fill"
        case .uberXL: return "car.fill"
        case .premier: return "bolt.car.fill"
        }
    }
    
    var priceMultiplier: Double {
        switch self {
        case .uberX: return 1.0
        case .uberXL: return 1.25
        case .premier: return 2.0
        }
    }
}

struct LocationSearchResult: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
}

enum RideState {
    case selectingDestination
    case confirmingRide
    case bookingRide
    case rideBooked
}
