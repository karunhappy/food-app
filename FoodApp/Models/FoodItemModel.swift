//
//  FoodItemModel.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import Foundation

struct FoodItemModel: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    var quantity: Int = 0
}
