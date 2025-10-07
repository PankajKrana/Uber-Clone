//
//  SettingView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        HStack {
                            Circle()
                                .stroke()
                                .frame(width: 80)
                                .overlay {
                                    Image("Erenjaeger")
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.circle)
                                }
                            
                            
                            
                            VStack(alignment: .leading) {
                                Text("Alex")
                                    .font(.headline)
                                    .bold()
                                Text("+91 7392748792")
                                    .font(.caption)
                                Text("alex123@gmail.com")
                                    .font(.caption)
                                
                            }
                            .padding(.horizontal)
                            
                            
                            
                        }
                        .foregroundStyle(Color.black)
                    }
                    
                    
                    
                    
                    Section(header: Text("App Settings")) {
                        AppSettingView(systemimage: "house.fill", text: "Add Home")
                        AppSettingView(systemimage: "suitcase.fill", text: "Add Work")
                        AppSettingView(systemimage: "escape", text: "Shortcuts")
                        AppSettingView(systemimage: "lock.fill", text: "Privacy", text2: "Manage the data you share with us")
                        AppSettingView(systemimage: "sun.max.fill", text: "Appearance", text2: "Use device settings")
                        AppSettingView(systemimage: "book.pages.fill", text: "Invoice information", text2: "Manage you accessibility settings")
                        
                        AppSettingView(systemimage: "figure", text: "Accessibility", text2: "Manage you accessibility settings")
                        AppSettingView(systemimage: "iphone.gen3.radiowaves.left.and.right", text: "Communication", text2: "Choose you preferred contact methods and manage your notification settings")
                        
                    }
                    
                    Section(header: Text("Safety")) {
                        AppSettingView(systemimage: "shield.fill", text: "Safety preferences", text2: "Choose and schedule you favourite safety tools")
                        
                        AppSettingView(systemimage: "person.2.shield", text: "Manage trusted contacts", text2: "Share your trip status with family and friends with a single tap")
                        
                        AppSettingView(systemimage: "car", text: "RideCheck", text2: "Manage your Ridecheck notification")
                        
                    }
                    
                    Section(header: Text("Trip preferences")) {
                        AppSettingView(systemimage: "calendar", text: "Reserve", text2: "Choose how you're matched with drivers when you book ahead")
                        
                        AppSettingView(systemimage: "umbrella.fill", text: "Rider insurance", text2: "Get insurance coverage on your trips")
                        
                        AppSettingView(systemimage: "iphone.gen1.radiowaves.left.and.right", text: "Driver nearby alert", text2: "Manage how you wnat ot be notified during pick-ups with long waits")
                        
                        AppSettingView(systemimage: "bell.fill", text: "Commute alerts", text2: "Plan your commute with traffic and waiting time details sent to your phone")
                        
                    }
                    
                    HStack {
                        Text("Switch account")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                }.listStyle(.inset)
                
                Button {
                    
                } label: {
                    Text("Sign Out")
                        .font(.title2)
                        .foregroundStyle(Color.red)
                }
                
            }
            .navigationTitle("Settings")
            
            
        }
    }
}

struct AppSettingView: View {
    @State var systemimage: String
    @State var text: String
    @State var text2: String?
    var body: some View {
        HStack {
            Image(systemName: systemimage)
            VStack(alignment: .leading) {
                Text(text)
                    .font(.headline)
                Text(text2 ?? "")
                    .font(.caption)
            }
            
        }
    }
}

#Preview {
    SettingView()
}
