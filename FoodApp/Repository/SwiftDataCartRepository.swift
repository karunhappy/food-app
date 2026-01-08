//
//  SwiftDataCartRepository.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import Foundation
import SwiftData

class SwiftDataCartRepository {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // save context
    func saveContext() {
        try? context.save()
    }
    
    /// insert items to CartItems
    /// paramters: [FoodItemModel]
    func save(items: [FoodItemModel]) {
        clear()
        
        for item in items where item.quantity > 0 {
            context.insert(
                CartItemSwiftData(
                    id: item.id,
                    name: item.name,
                    quantity: item.quantity,
                    price: item.price
                )
            )
        }
    }
    
    /// delete items from CartItems
    /// parameter: CartItemSwiftData
    func delete(item: CartItemSwiftData) {
        context.delete(item)
    }
    
    /// fetch/load items from storage
    /// return [CartItemSwiftData]
    func fetch() -> [CartItemSwiftData] {
        (try? context.fetch(FetchDescriptor<CartItemSwiftData>())) ?? []
    }
    
    /// remove all items from storage
    func clear() {
        let items = try? context.fetch(FetchDescriptor<CartItemSwiftData>())
        items?.forEach({ context.delete($0) })
    }
}
