//
//  HomeViewModel.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import Foundation
import SwiftUICore
import SwiftData

class HomeViewModel: ObservableObject {
    
    // mock food items
    @Published var items: [FoodItemModel] = [
        FoodItemModel(name: "Pizza", price: 299),
        FoodItemModel(name: "Burger", price: 149),
        FoodItemModel(name: "Pasta", price: 199),
        FoodItemModel(name: "Sandwich", price: 99)
    ]
    
    // calcualte total items
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    // calculate total price
    var totalPrice: Double {
        items.reduce(0) { $0 + (Double($1.quantity) * $1.price) }
    }
    
    // check total items are greater than 0 and display bottom Add to cart on HomeView
    var showBottombar: Bool {
        totalItems > 0
    }
    
    // reset/clear cart
    func resetCart() {
        for index in items.indices {
            items[index].quantity = 0
        }
    }
    
    // add item to storage
    func increment(_ item: FoodItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index].quantity += 1
        }
    }
    
    // reduce item to storage
    func decrement(_ item: FoodItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}),
           items[index].quantity > 0 {
            items[index].quantity -= 1
        }
    }
    
    // persist/save to storage
    func persistCart(using context: ModelContext) {
        SwiftDataCartRepository(context: context)
            .save(items: items)
    }
}
