//
//  RootView.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(1)
            AdminView()
                .tabItem {
                    Label("Admin", systemImage: "server.rack")
                }
                .tag(2)
        }
    }
}

#Preview {
    RootView()
}
