//
//  HelpView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct HelpView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    
                    VStack(spacing: 10) {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.blue)
                        
                        Text("Help Center")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Find answers to your questions or get support")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    
                    TextField("Search help articles...", text: $searchText)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                        .padding(.horizontal)
                    
                    // Quick Help Topics
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Popular Topics")
                            .font(.headline)
                        
                        HelpTopicCard(title: "Trip Issues", subtitle: "Report a problem with your ride", icon: "car.fill")
                        HelpTopicCard(title: "Payments & Refunds", subtitle: "Manage payment methods or request refunds", icon: "creditcard.fill")
                        HelpTopicCard(title: "Account & App", subtitle: "Update account info or troubleshoot app issues", icon: "person.fill")
                        HelpTopicCard(title: "Safety & Privacy", subtitle: "Learn about safety features & privacy controls", icon: "shield.lefthalf.fill")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Need more help?")
                            .font(.headline)
                        
                        Button {
                            // Action: Open support chat
                        } label: {
                            HStack {
                                Image(systemName: "message.fill")
                                Text("Chat with Support")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray5)))
                        }
                        
                        Button {
                            // Action: Call support
                        } label: {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Call Support")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray5)))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                }
                .padding()
            }
            .navigationTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct HelpTopicCard: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HelpView()
}
