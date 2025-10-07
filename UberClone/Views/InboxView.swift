//
//  InboxView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct InboxView: View {
    @State private var messages: [RideMessage] = [
        RideMessage(title: "Your ride is arriving", body: "Your driver is 2 mins away. Get ready!", date: "Sep 5, 2025", icon: "car.fill"),
        RideMessage(title: "Promo Applied 🎉", body: "You saved ₹50 on your last trip.", date: "Sep 4, 2025", icon: "gift.fill"),
        RideMessage(title: "Safety Check", body: "Remember to wear your seatbelt.", date: "Sep 3, 2025", icon: "shield.fill"),
        RideMessage(title: "Trip Receipt", body: "Your trip to Connaught Place was ₹220.", date: "Sep 2, 2025", icon: "doc.text.fill")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(messages) { message in
                    NavigationLink {
                        MessageDetailView(message: message)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: message.icon)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(message.title)
                                    .font(.headline)
                                Text(message.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            Spacer()
                            Text(message.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Inbox")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MessageDetailView: View {
    let message: RideMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: message.icon)
                    .font(.title)
                    .foregroundColor(.blue)
                Text(message.title)
                    .font(.title2)
                    .bold()
            }
            
            Text(message.body)
                .font(.body)
            
            Spacer()
            
            Text("Received on \(message.date)")
                .font(.footnote)
                .foregroundColor(.gray)
            
        }
        .padding()
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    InboxView()
}
