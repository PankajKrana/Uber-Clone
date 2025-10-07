//
//  ProfileView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/4/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image("Erenjaeger")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                
                
                Text("Alex")
                    .font(.title)
                    .fontWeight(.semibold)
                
                
                List {
                    Section(header: Text("Personal Info")) {
                        HStack {
                            Text("Gender")
                            Spacer()
                            Text("Male")
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("Phone Number")
                            Spacer()
                            Text("+91 28938 932791")
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("Email")
                            Spacer()
                            Text("alex1232@gmail.com")
                        }
                        HStack {
                            Text("Language")
                            Spacer()
                            Text("English")
                        }
                    }
                    
                    Section(header: Text("Security")) {
                        HStack {
                            Text("Change Password")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        HStack {
                            Text("Passkeys")
                            Spacer()
                            Image(systemName: "key")
                        }
                        HStack {
                            Text("2-step verification")
                            Spacer()
                            Image(systemName: "person.badge.key")
                        }
                        VStack(alignment: .leading) {
                            Text("Recovery Verification")
                            Spacer()
                            Text("add a backup phone number to access you account")
                                .font(.caption)
                        }
                    }
                    
                    
                }
                .listStyle(.inset)
                
                
            }
            .padding()
            
            
        }
    }
}

#Preview {
    ProfileView()
}

