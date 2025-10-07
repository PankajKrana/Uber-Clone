//
//  SafetyCheckupView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct SafetyCheckupView: View {
    
    @State private var seatbeltOn: Bool = false
    @State private var helmetOn: Bool = false
    @State private var emergencyContactsAdded: Bool = false
    @State private var safetyConfirmed: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    VStack(spacing: 10) {
                        Image(systemName: "shield.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.blue)
                        
                        Text("Safety Check-up")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Make sure you are prepared for a safe ride 🚖")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 15) {
                        SafetyToggle(title: "Seatbelt fastened", isOn: $seatbeltOn, icon: "car.seatbelt.fill")
                        SafetyToggle(title: "Helmet on (if bike)", isOn: $helmetOn, icon: "helmetsafety.fill")
                        SafetyToggle(title: "Emergency contacts added", isOn: $emergencyContactsAdded, icon: "person.2.fill")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                    
                    
                    Button {
                        safetyConfirmed = true
                    } label: {
                        Text("Confirm Safety ✅")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .disabled(!(seatbeltOn && emergencyContactsAdded))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Safety Check-up")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Safety Confirmed ✅", isPresented: $safetyConfirmed) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("You are ready for a safe ride!")
            }
        }
    }
}


struct SafetyToggle: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                Text(title)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .blue))
    }
}

#Preview {
    SafetyCheckupView()
}

