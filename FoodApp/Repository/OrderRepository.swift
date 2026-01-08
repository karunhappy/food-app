//
//  OrderRepository.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 06/01/26.
//

import Foundation
import FirebaseFirestore

class OrderRepository {
    private let db = Firestore.firestore()
    
    /// Place order and add to Firestore
    /// paramters: OrderModel
    /// return: completion with Result
    func placeOrder(
        order: OrderModel,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection("orders")
            .addDocument(
                data: codableToDictionary(order) ?? [:],
                completion: { error in
                    if let error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            )
    }
    
        /// Fetch order from Firestore
        /// paramters:
        /// return: completion with Result<[OrderModel]>
    func fetchOrders(completion: @escaping (Result<[OrderModel], Error>) -> Void) {
        db.collection("orders")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                if let error {
                    completion(.failure(error))
                    return
                }
                let orders = snapshot?.documents.compactMap {
                    try? $0.data(as: OrderModel.self)
                } ?? []
                
                completion(.success(orders))
            }
    }
}
