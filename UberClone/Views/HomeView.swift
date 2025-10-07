//
//  HomeView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/3/25.
//


import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var recentActivities = [
        "Car ride to Connaught Place 🚗",
        "Metro trip to Rajiv Chowk 🚇",
        "Bike ride to India Gate 🏍️"
    ]
    
    let services = [
    
        Services(title: "Trip", systemImage: "car", color: .blue),
        Services(title: "Rentals", systemImage: "car.badge.gearshape", color: .green),
        Services(title: "Intercity", systemImage: "car.rear.road.lane", color: .purple),
        Services(title: "Reserve", systemImage: "clock", color: .orange)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    NavigationLink {
                        UberMapView()
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            Text("Enter pick-up location")
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Capsule()
                                .fill(Color.black)
                                .frame(width: 100, height: 35)
                                .overlay {
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.white)
                                        Text("Later")
                                            .foregroundColor(.white)
                                    }
                                }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            NavigationLink {
                                UberMapView()
                            } label: {
                                PromoCard(text1: "Enjoy 40% off Courier", text2: "Book now", imageName: "car")

                            }
                            
                            NavigationLink {
                                UberMapView()
                            } label: {
                                PromoCard(text1: "Special Offer", text2: "Ride now", imageName: "car")

                            }
                            
                            NavigationLink {
                                UberMapView()
                            } label: {
                                PromoCard(text1: "Try Rentals Today", text2: "Book now", imageName: "car")

                            }



                        }
                        .padding(.horizontal)
                    }
                    
                    
                    HStack {
                        Text("Services")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("See all")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(services, id: \.title) { service in
                                MiniCardView(service: service)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ForEach(recentActivities, id: \.self) { activity in
                            HStack(spacing: 16) {
                                Image(systemName: iconFor(activity: activity))
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                
                                Text(activity)
                                    .font(.subheadline)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    
                }
                .padding(.vertical)
            }
            .navigationTitle("Uber")
        }
    }
    
    
    private func iconFor(activity: String) -> String {
        if activity.contains("Car") {
            return "car.fill"
        } else if activity.contains("Metro") {
            return "tram.fill"
        } else if activity.contains("Bike") {
            return "bicycle"
        }
        return "location.fill"
    }
}


struct MiniCardView: View {
    let service: Services
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: service.systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            
            Text(service.title)
                .foregroundColor(.white)
                .font(.headline)
        }
        .frame(width: 100, height: 140)
        .background(service.color.gradient)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}


struct PromoCard: View {
    let text1: String
    let text2: String
    let imageName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 3)
                .frame(width: 300, height: 180)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(text1).bold()
                    Text(text2)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial, in: Capsule())
                }
                Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            .padding()
        }
    }
}

struct Services {
    let title: String
    let systemImage: String
    let color: Color

}


#Preview {
    HomeView()
}
