//
//  BusinessProfileView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

struct BusinessProfileView: View {
    
    @State private var companyName: String = ""
    @State private var workEmail: String = ""
    @State private var autoExpenseReports: Bool = true
    @State private var tripTagging: Bool = false
    @State private var profileSaved: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Company Details")) {
                    TextField("Company Name", text: $companyName)
                        .textInputAutocapitalization(.words)
                    TextField("Work Email", text: $workEmail)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                }
                
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $autoExpenseReports) {
                        Label("Automatic Expense Reports", systemImage: "doc.text.fill")
                    }
                    
                    Toggle(isOn: $tripTagging) {
                        Label("Enable Trip Tagging", systemImage: "tag.fill")
                    }
                }
                
                Section {
                    Button {
                        profileSaved = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save Business Profile")
                                .bold()
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            .navigationTitle("Business Profile")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Profile Saved ✅", isPresented: $profileSaved) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Your business profile has been updated.")
            }
        }
    }
}

#Preview {
    BusinessProfileView()
}
