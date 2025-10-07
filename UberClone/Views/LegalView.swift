//
//  LegalView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI

let sampleTerms = """
These are the sample Terms & Conditions. In a real app, this would contain the complete terms of service for using Uber.
"""

let samplePrivacy = """
This is the sample Privacy Policy. In a real app, this would explain how your data is collected, stored, and used.
"""

let sampleLicenses = """
This app uses open-source libraries. License details will be displayed here.
"""


struct LegalView: View {
    @State private var showTerms = false
    @State private var showPrivacy = false
    @State private var showLicenses = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Legal Documents")) {
                    Button {
                        showTerms.toggle()
                    } label: {
                        Label("Terms & Conditions", systemImage: "doc.text.fill")
                    }
                    .sheet(isPresented: $showTerms) {
                        LegalDetailView(title: "Terms & Conditions", content: sampleTerms)
                    }
                    
                    Button {
                        showPrivacy.toggle()
                    } label: {
                        Label("Privacy Policy", systemImage: "lock.doc.fill")
                    }
                    .sheet(isPresented: $showPrivacy) {
                        LegalDetailView(title: "Privacy Policy", content: samplePrivacy)
                    }
                    
                    Button {
                        showLicenses.toggle()
                    } label: {
                        Label("Open Source Licenses", systemImage: "doc.richtext")
                    }
                    .sheet(isPresented: $showLicenses) {
                        LegalDetailView(title: "Open Source Licenses", content: sampleLicenses)
                    }
                }
            }
            .navigationTitle("Legal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct LegalDetailView: View {
    let title: String
    let content: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(content)
                    .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



#Preview {
    LegalView()
}
