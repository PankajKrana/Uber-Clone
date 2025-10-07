//
//  WalletView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let date: String
}

struct WalletView: View {
    @State private var balance: Double = 1240.50
    @State private var transactions: [Transaction] = [
        Transaction(title: "Uber Ride - Connaught Place", amount: -220, date: "Sep 3, 2025"),
        Transaction(title: "Gift Card Added", amount: +500, date: "Sep 1, 2025"),
        Transaction(title: "Uber Eats - Burger King", amount: -320, date: "Aug 30, 2025")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    
                    VStack(spacing: 10) {
                        Text("Uber Cash")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Text("₹\(String(format: "%.2f", balance))")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.green)
                        
                        Button {
                            
                        } label: {
                            Text("Add Money")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Payment Methods")
                            .font(.headline)
                        
                        PaymentMethodCard(name: "Visa **** 1234", icon: "creditcard.fill")
                        PaymentMethodCard(name: "Google Pay", icon: "g.circle.fill")
                        PaymentMethodCard(name: "PayPal", icon: "p.circle.fill")
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                Text("Add Payment Method")
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray5)))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Transactions")
                            .font(.headline)
                        
                        ForEach(transactions) { txn in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(txn.title)
                                        .font(.subheadline)
                                    Text(txn.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text(txn.amount >= 0 ? "+₹\(txn.amount)" : "₹\(txn.amount)")
                                    .font(.subheadline)
                                    .foregroundColor(txn.amount >= 0 ? .green : .red)
                            }
                            Divider()
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
            }
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct PaymentMethodCard: View {
    let name: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray5)))
    }
}




#Preview {
    WalletView()
}
