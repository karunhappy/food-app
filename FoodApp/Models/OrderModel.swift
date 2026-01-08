//
//  OrderModel.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 06/01/26.
//

import Foundation
import FirebaseFirestore

struct OrderItemModel: Codable {
    let name: String
    let quantity: Int
    let price: Double
}

struct OrderModel: Codable {
    @DocumentID var id: String?
    let name: String
    let phone: String
    let totalAmount: Double
    let items: [OrderItemModel]
    let createdAt: Date
}

func codableToDictionary<T: Encodable>(_ codable: T) -> [String: Any]? {
    do {
        let encoder = Firestore.Encoder()
        let dictionary = try encoder.encode(codable)
        return dictionary
    } catch {
        print("Error converting to dictionary: \(error)")
        return nil
    }
}
