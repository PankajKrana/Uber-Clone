//
//  PrivacyCheckupView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct PrivacyCheckupView: View {
    
    @State private var locationSharing: Bool = true
    @State private var rideHistoryVisible: Bool = false
    @State private var marketingEmails: Bool = false
    @State private var twoFactorEnabled: Bool = true
    @State private var checkupComplete: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    
                    VStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.purple)
                        
                        Text("Privacy Check-up")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Review your privacy settings to stay in control 🔒")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 15) {
                        PrivacyToggle(title: "Share location with drivers only during rides", isOn: $locationSharing, icon: "location.fill")
                        PrivacyToggle(title: "Hide my ride history from friends", isOn: $rideHistoryVisible, icon: "clock.fill")
                        PrivacyToggle(title: "Receive marketing emails", isOn: $marketingEmails, icon: "envelope.fill")
                        PrivacyToggle(title: "Enable 2FA for account security", isOn: $twoFactorEnabled, icon: "key.fill")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                    
                    
                    Button {
                        checkupComplete = true
                    } label: {
                        Text("Save Privacy Settings")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Privacy Check-up")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Settings Saved ✅", isPresented: $checkupComplete) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your privacy settings have been updated.")
            }
        }
    }
}


struct PrivacyToggle: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .frame(width: 30)
                Text(title)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .purple))
    }
}

#Preview {
    PrivacyCheckupView()
}
