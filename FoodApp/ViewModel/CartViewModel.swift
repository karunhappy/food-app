//
//  CartViewModel.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import Foundation
import SwiftData

class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemSwiftData] = []
    
    private var repository: SwiftDataCartRepository?
    private var orderRepository = OrderRepository()
    
    // confugure ModelContext
    func configure(context: ModelContext) {
        self.repository = SwiftDataCartRepository(context: context)
        loadCart()
    }
    
    // load cart items from storage
    func loadCart() {
        cartItems = repository?.fetch() ?? []
    }
    
    // save cart items from storage
    private func persist() {
        repository?.saveContext()
        loadCart()
    }
    
    // add cart items to storage
    func increment(_ item: CartItemSwiftData) {
        item.quantity += 1
        persist()
    }
    
    // reduce cart items to storage
    func decrement(_ item: CartItemSwiftData) {
        item.quantity -= 1
        if item.quantity <= 0 {
            repository?.delete(item: item)
        } else {
            persist()
        }
        loadCart()
    }
    
    // remove cart items from storage
    func delete(_ item: CartItemSwiftData) {
        repository?.delete(item: item)
        persist()
    }
    
    // submit order to firestore
    func submitOrder(name: String, phone: String, completion: @escaping (Bool) -> Void) {
        loadCart()
        let orderItems = cartItems.map {
            OrderItemModel(name: $0.name, quantity: $0.quantity, price: $0.price)
        }
        var totalPrice: Double {
            orderItems.reduce(0) { $0 + (Double($1.quantity) * $1.price) }
        }
        let order = OrderModel(name: name, phone: phone, totalAmount: totalPrice, items: orderItems, createdAt: Date())
        
        orderRepository.placeOrder(order: order) { [weak self] result in
            switch result {
                case .success:
                    completion(true)
                    self?.repository?.clear()
                    self?.persist()
                    break
                case .failure(let err):
                    completion(false)
                    print(err.localizedDescription)
            }
        }
    }
}
