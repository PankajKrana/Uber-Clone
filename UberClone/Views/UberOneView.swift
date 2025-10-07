//
//  UberOneView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct UberOneView: View {
    @State private var selectedPlan: String = "Monthly"
    @State private var isSubscribed: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    
                    VStack(spacing: 12) {
                        Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.yellow)
                        
                        Text("Uber One")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Unlock premium benefits for rides and delivery 🚀")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Membership Benefits")
                            .font(.headline)
                        
                        Label("15% off on rides", systemImage: "car.fill")
                        Label("5% off on food & grocery orders", systemImage: "takeoutbag.and.cup.and.straw.fill")
                        Label("Premium support", systemImage: "person.fill.questionmark")
                        Label("Zero delivery fee on eligible orders", systemImage: "bicycle")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Choose Your Plan")
                            .font(.headline)
                        
                        HStack(spacing: 15) {
                            PlanCard(title: "Monthly", price: "₹299", isSelected: selectedPlan == "Monthly") {
                                selectedPlan = "Monthly"
                            }
                            
                            PlanCard(title: "Annual", price: "₹2999", isSelected: selectedPlan == "Annual") {
                                selectedPlan = "Annual"
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    Spacer(minLength: 30)
                    
                    
                    Button {
                        isSubscribed = true
                    } label: {
                        Text(isSubscribed ? "Subscribed ✅" : "Subscribe to Uber One")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isSubscribed ? Color.green : Color.black)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Uber One")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Subscription Successful 🎉", isPresented: $isSubscribed) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You are now subscribed to Uber One (\(selectedPlan) plan).")
            }
        }
    }
}



struct PlanCard: View {
    let title: String
    let price: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Text(title)
                    .font(.headline)
                Text(price)
                    .font(.title2)
                    .bold()
            }
            .frame(width: 140, height: 100)
            .background(isSelected ? Color.blue.opacity(0.8) : Color(.systemGray5))
            .foregroundStyle(isSelected ? .white : .black)
            .cornerRadius(15)
        }
    }
}

#Preview {
    UberOneView()
}
