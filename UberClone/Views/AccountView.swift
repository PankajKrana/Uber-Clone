//
//  AccountView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/3/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack(spacing: 20) {
                    Text("Alex")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Circle()
                            .stroke()
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image("Erenjaeger")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.circle)
                            }
                    }

                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)
                
                
                MiniCardRectView()
                    .padding(.horizontal)
                
                List {
                    Section {
                        NavigationLink {
                            RiderInsuranceView()
                        } label: {
                            ListView(title1: "Rider Insurance", title2: "$10k cover for $4/trip", sysImage: "beach.umbrella")

                        }
                        
                        NavigationLink {
                            SafetyCheckupView()
                        } label: {
                            ListView(title1: "Safety check-up", title2: "Learn ways to make riders safer", sysImage: "circle.dashed")

                        }
                        
                        NavigationLink {
                            PrivacyCheckupView()
                        } label: {
                            
                            ListView(title1: "Privacy check-up", title2: "Take an interactive tour of your privacy settings", sysImage: "book.and.wrench")

                        }


                    }
                    
                    Section {
                        
                        NavigationLink {
                            SettingView()
                        } label: {
                            List1View(systemImage: "gear", text: "Setting")
                        }
                        
                        NavigationLink {
                            PrivacyCheckupView()
                        } label: {
                            List1View(systemImage: "iphone.gen1", text: "Simple Mode", text2: "A simplified app for older adults")

                        }

                        NavigationLink {
                            SendGiftView()
                        } label: {
                            List1View(systemImage: "gift.fill", text: "Send a gift")


                        }


                        NavigationLink {
                            UberOneView()
                        } label: {
                            List1View(systemImage: "globe.americas", text: "Uber One", text2: "Earn up to 15% Uber One credits on rides")

                        }
                        NavigationLink {
                            SavedGroupsView()
                        } label: {
                            List1View(systemImage: "person.2", text: "Saved groups")

                        }
                        
                        NavigationLink {
                            BusinessProfileView()
                        } label: {
                            List1View(systemImage: "suitcase", text: "Business profile", text2: "Automate work travel & meal expenses")

                        }
                    
                        
                        NavigationLink {
                            LegalView()
                        } label: {
                            List1View(systemImage: "i.circle", text: "Legal")

                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MiniCardRectView: View {
    var body: some View {
        HStack(spacing: 10) {
            NavigationLink {
                HelpView()
            } label: {
                MiniCard(title: "Help", icon: "circle.dashed")
                
            }
            
            NavigationLink {
                WalletView()
            } label: {
                MiniCard(title: "Wallet", icon: "wallet.bifold")
                
            }
            
            NavigationLink {
                InboxView()
            } label: {
                MiniCard(title: "Inbox", icon: "envelope.fill")

            }
        }
    }
}

struct MiniCard: View {
    let title: String
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke()
            .frame(width: 110, height: 110)
            .overlay {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.largeTitle)
                    Text(title)
                        .font(.headline)
                }
                .foregroundStyle(.black)
            }
    }
}


struct ListView: View {
    let title1: String
    let title2: String
    let sysImage: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title1)
                    .font(.callout)
                Text(title2)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: sysImage)
                .font(.title2)
                .foregroundColor(.blue)
        }
    }
}

struct List1View: View {
    @State var systemImage: String
    @State var text: String
    @State var text2: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .foregroundColor(.blue)
                Text(text)
            }
            Text(text2 ?? "")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.leading, 32)

        }
    }
}

#Preview {
    AccountView()
}
