//
//  RiderInsuranceView.swift
//  SimpleUberApp
//
//  Created by Pankaj on 9/5/25.
//

import SwiftUI

struct RiderInsuranceView: View {
    @State var insuranceEnabled = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    
                    VStack(spacing: 10) {
                        Image(systemName: "shield.checkerboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.blue)
                        
                        Text("Rider Insurance")
                            .font(.title2)
                            .bold()
                        
                        Text("Protect yourself with ride insurance for peace of mind.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Coverage Includes:")
                            .font(.headline)
                        
                        Label("Accidental medical expenses up to ₹5,00,000", systemImage: "cross.case.fill")
                        Label("Personal accident cover up to ₹10,00,000", systemImage: "heart.fill")
                        Label("Daily hospital cash benefits", systemImage: "bed.double.fill")
                        Label("Lost baggage protection", systemImage: "bag.fill.badge.plus")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Insurance Cost")
                            .font(.headline)
                        Text("₹20 per ride")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.green)
                        Text("Charged only when enabled.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    Spacer(minLength: 30)
                    
                    // Toggle Switch
                    Toggle(isOn: $insuranceEnabled) {
                        Text("Enable Insurance for this Ride")
                            .font(.headline)
                    }
                    .padding()
                    
                    
                    Button {
                        
                    } label: {
                        Text(insuranceEnabled ? "Insurance Enabled ✅" : "Enable Insurance")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(insuranceEnabled ? Color.green : Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Insurance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RiderInsuranceView()
}
