//
//  CartItemSwiftData.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftData
import Foundation

@Model
class CartItemSwiftData: Identifiable {
    var id: UUID
    var name: String
    var quantity: Int
    var price: Double
    
    init(id: UUID, name: String, quantity: Int, price: Double) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}
