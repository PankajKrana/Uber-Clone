//
//  UberMapView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 07/10/25.
//

import SwiftUI
import MapKit

struct UberMapView: View {
    
    @StateObject private var viewModel = UberMapViewModel()
    @FocusState private var isDestinationFieldFocused: Bool
    
    var body: some View {
        ZStack {
            mapView
            
            VStack {
                searchInterface
                Spacer()
                bottomInterface
            }
        }
    }
    
    
    private var mapView: some View {
        Map(position: $viewModel.camera) {
            Annotation("You", coordinate: viewModel.selectedPickup) {
                ZStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 20, height: 20)
                    Circle()
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 20, height: 20)
                }
            }
            
            if let destination = viewModel.selectedDestination {
                Annotation("Destination", coordinate: destination) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            }
            
            if let route = viewModel.route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 5)
            }
            
            ForEach(viewModel.drivers.indices, id: \.self) { index in
                let driver = viewModel.drivers[index]
                Annotation("Driver \(index + 1)", coordinate: driver) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                        
                        if index % 2 == 0 {
                            Image(systemName: "car.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        } else {
                            Image(systemName: "motorcycle.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            viewModel.dismissSearch()
            isDestinationFieldFocused = false
        }
    }
    
    
    private var searchInterface: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                HStack {
                    VStack(spacing: 8) {
                        Circle()
                            .fill(.blue)
                            .frame(width: 8, height: 8)
                        
                        Rectangle()
                            .fill(.gray.opacity(0.3))
                            .frame(width: 2, height: 20)
                        
                        Rectangle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                    }
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text(viewModel.pickupLocation)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            Spacer()
                        }
                        
                        HStack {
                            TextField("Where to?", text: $viewModel.destination)
                                .focused($isDestinationFieldFocused)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .cornerRadius(8)
                                .onTapGesture {
                                    viewModel.isSearchingDestination = true
                                    isDestinationFieldFocused = true
                                    viewModel.updateSearchResults()
                                }
                                .onChange(of: viewModel.destination) { _, _ in
                                    viewModel.handleDestinationChange()
                                }
                                .onChange(of: isDestinationFieldFocused) { _, isFocused in
                                    viewModel.handleSearchFocusChange(isFocused: isFocused)
                                }
                            
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.horizontal)
            
            if viewModel.isSearchingDestination && !viewModel.searchResults.isEmpty {
                searchResultsList
            }
        }
    }
    
    private var searchResultsList: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.searchResults) { result in
                Button {
                    viewModel.selectDestination(result)
                    isDestinationFieldFocused = false
                } label: {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(result.name)
                                .font(.headline)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            Text(result.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                
                if result.id != viewModel.searchResults.last?.id {
                    Divider()
                        .padding(.horizontal, 16)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 4)
    }
    
    
    private var bottomInterface: some View {
        VStack {
            switch viewModel.rideState {
            case .selectingDestination:
                EmptyView()
            case .confirmingRide:
                rideConfirmationView
            case .bookingRide:
                bookingView
            case .rideBooked:
                rideBookedView
            }
        }
    }
    
    // MARK: - Ride Confirmation View
    private var rideConfirmationView: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Estimated Time")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.estimatedTime)
                        .font(.headline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Estimated Fare")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.estimatedPrice)
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            VStack(spacing: 12) {
                ForEach(RideOption.allCases, id: \.self) { option in
                    RideOptionRow(
                        title: option.rawValue,
                        subtitle: option.subtitle,
                        price: viewModel.calculatePrice(for: option),
                        time: viewModel.estimatedTime,
                        isSelected: viewModel.selectedRideOption == option,
                        systemImages: option.systemImage
                    ) {
                        viewModel.selectRideOption(option)
                    }
                }
            }
            
            Button {
                viewModel.bookRide()
            } label: {
                Text("Confirm \(viewModel.selectedRideOption.rawValue)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
    }
    
    
    private var bookingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text("Finding your driver...")
                .font(.headline)
            
            Text("This may take a few moments")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button("Cancel") {
                viewModel.cancelBooking()
            }
            .foregroundColor(.red)
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 40)
    }
    
    
    private var rideBookedView: some View {
        VStack(spacing: 16) {
            HStack {
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Rajesh Kumar")
                        .font(.headline)
                    Text("\(viewModel.selectedRideOption.rawValue) • DL 01 CA 1234")
                        .font(.caption)
                        .foregroundColor(.gray)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text("4.8")
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("3 min")
                        .font(.headline)
                    Text("away")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 20) {
                Button {
                    // Call driver
                } label: {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .clipShape(Circle())
                }
                
                Button {
                    // Message driver
                } label: {
                    Image(systemName: "message.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button("Cancel Ride") {
                    viewModel.cancelRide()
                }
                .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
    }
}


struct RideOptionRow: View {
    let title: String
    let subtitle: String
    let price: String
    let time: String
    let isSelected: Bool
    let systemImages: String
    var onTap: () -> Void = {}
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: systemImages)
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.headline)
                        Text(time)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(price)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    UberMapView()
}
