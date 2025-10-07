//
//  ServiceView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/3/25.
//

import SwiftUI


struct Service: Identifiable {
    let id = UUID()
    let title: String
    let systemImage: String
    let subtitle: String?
    let color: Color
    let badge: String?
}


struct ServiceView: View {
    
    let services: [Service] = [
        Service(title: "Trip", systemImage: "car", subtitle: "Book now", color: .blue, badge: "Popular"),
        Service(title: "Rentals", systemImage: "car.badge.gearshape", subtitle: "Hourly rental", color: .green, badge: nil),
        Service(title: "Intercity", systemImage: "car.rear.road.lane", subtitle: "Go far away", color: .purple, badge: nil),
        Service(title: "Reserve", systemImage: "clock", subtitle: "Plan ahead", color: .orange, badge: "New"),
        Service(title: "Bike", systemImage: "bicycle", subtitle: "Quick rides", color: .pink, badge: nil),
        Service(title: "Scooter", systemImage: "scooter", subtitle: "Last mile", color: .yellow, badge: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(services) { service in
                            NavigationLink {
                                ServiceDetailView(service: service)
                            } label: {
                                MiniCardViewImproved(service: service)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                Spacer()
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Services").font(.headline)
                        Text("Choose your ride").font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
        }
    }
}


struct MiniCardViewImproved: View {
    let service: Service
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 10) {
                Image(systemName: service.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                
                Text(service.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                if let subtitle = service.subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .frame(width: 100, height: 140)
            .background(service.color.gradient)
            .cornerRadius(20)
            .shadow(radius: 5)
            
            if let badge = service.badge {
                Text(badge)
                    .font(.caption2.bold())
                    .padding(4)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .padding(6)
            }
        }
    }
}

// MARK: - Detail View
struct ServiceDetailView: View {
    let service: Service
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: service.systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(service.color)
            
            Text(service.title)
                .font(.largeTitle)
                .bold()
            
            if let subtitle = service.subtitle {
                Text(subtitle)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(service.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ServiceView()
}
