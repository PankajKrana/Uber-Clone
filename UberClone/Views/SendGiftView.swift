//
//  SendGiftView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct SendGiftView: View {
    @State private var recipientName: String = ""
    @State private var recipientEmail: String = ""
    @State private var selectedAmount: Int? = nil
    @State private var customAmount: String = ""
    @State private var message: String = ""
    @State private var isGiftSent: Bool = false
    
    let giftAmounts = [200, 500, 1000, 2000]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    
                    VStack(spacing: 10) {
                        Image(systemName: "gift.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.pink)
                        
                        Text("Send a Gift")
                            .font(.title)
                            .bold()
                        Text("Surprise someone with Uber credits 🎉")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recipient Details")
                            .font(.headline)
                        
                        TextField("Name", text: $recipientName)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Email", text: $recipientEmail)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Choose Amount")
                            .font(.headline)
                        
                        HStack {
                            ForEach(giftAmounts, id: \.self) { amount in
                                Button {
                                    selectedAmount = amount
                                    customAmount = ""
                                } label: {
                                    Text("₹\(amount)")
                                        .frame(width: 80, height: 40)
                                        .background(selectedAmount == amount ? Color.blue : Color(.systemGray5))
                                        .foregroundStyle(selectedAmount == amount ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        TextField("Custom Amount (₹)", text: $customAmount)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: customAmount, { _, _ in
                                selectedAmount = nil
                            })
                        }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Message")
                            .font(.headline)
                        
                        TextEditor(text: $message)
                            .frame(height: 100)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4)))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    
                    
                    Button {
                        isGiftSent = true
                    } label: {
                        Text("Send Gift")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .disabled(recipientName.isEmpty || recipientEmail.isEmpty || (selectedAmount == nil && customAmount.isEmpty))
                    
                }
                .padding()
            }
            .navigationTitle("Send Gift")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Gift Sent 🎉", isPresented: $isGiftSent) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your gift has been sent to \(recipientName).")
            }
        }
    }
}

#Preview {
    SendGiftView()
}
