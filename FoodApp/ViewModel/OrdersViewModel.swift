//
//  OrdersViewModel.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 07/01/26.
//

import Foundation

class OrdersViewModel: ObservableObject {
    
    @Published var orders: [OrderModel] = []
    @Published var isLoading = false
    
    private let repository = OrderRepository()
    
    // load orders from Firestore
    func loadOrders() {
        isLoading = true
        
        repository.fetchOrders { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                    case .success(let orders):
                        self?.orders = orders
                    case .failure:
                        self?.orders = []
                }
            }
        }
    }
}
