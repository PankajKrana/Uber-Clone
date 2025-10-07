//
//  ContentView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/3/25.
//

import SwiftUI

struct MainView: View {
    @State var textSearch: String = ""
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            
            
            Tab("Service", systemImage: "cable.coaxial") {
                ServiceView()
            }
            
            Tab("Activity", systemImage: "point.topleft.down.to.point.bottomright.curvepath") {
                ActivityView()
            }
            
            Tab("Account", systemImage: "person.fill") {
                AccountView()
            }
            
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainView()
}
