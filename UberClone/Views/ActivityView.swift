//
//  ActivityView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/3/25.
//

import SwiftUI

struct ActivityView: View {
    @State private var activities = [
        "Car ride to Connaught Place 🚗",
        "Metro trip to Rajiv Chowk 🚇",
        "Bike ride to India Gate 🏍️",
        "Carpool to Gurgaon 🚘",
        "Metro trip to Noida Sector 18 🚉",
        "Scooter ride to Lodhi Garden 🛵"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                
                HStack(spacing: 20) {
                    Text(" Activity Past")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        
                        if let newActivity = activities.randomElement() {
                            activities.insert(newActivity, at: 0)
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                
                
                if activities.isEmpty {
                    Text("You don't have any recent activity yet.")
                        .font(.callout)
                        .bold()
                        .padding(.top, 40)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(activities, id: \.self) { activity in
                                HStack(spacing: 15) {
                                    Image(systemName: iconFor(activity: activity))
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                        .frame(width: 40, height: 40)
                                    
                                    Text(activity)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    
    private func iconFor(activity: String) -> String {
        if activity.contains("Car") || activity.contains("carpool") {
            return "car.fill"
        } else if activity.contains("Metro") {
            return "tram.fill"
        } else if activity.contains("Bike") || activity.contains("Scooter") {
            return "bicycle"
        }
        return "location.fill"
    }
}

#Preview {
    ActivityView()
}
