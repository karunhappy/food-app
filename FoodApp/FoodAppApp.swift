//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct FoodAppApp: App {
    init() {
        // configure firebase
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: CartItemSwiftData.self)
    }
}
