//
//  AdminView.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftUI

struct AdminView: View {
    
    @StateObject private var viewModel = OrdersViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.orders.isEmpty {
                    Text("No orders found")
                        .foregroundStyle(.gray)
                } else {
                    List(
                        Array(viewModel.orders.enumerated()),
                        id: \.element.id
                    ) { index, order in
                        VStack(alignment: .leading, spacing: 6) {
                            // order no
                            Text("Order No: \(index + 1)").fontWeight(.bold)
                            
                            // order date
                            Text("Order Date: ").fontWeight(.bold)
                            + Text(order.createdAt.formatted())
                            
                            // customer name
                            Text("Customer Name: ").fontWeight(.bold)
                            + Text(order.name)
                            
                            // customer phone
                            Text("Customer Phone: ").fontWeight(.bold)
                            + Text(order.phone)
                            
                            // list of ordered items
                            Text("Order Items").fontWeight(.bold)
                                .font(.callout)
                            ForEach(order.items, id: \.name) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                        
                                    Text("\(item.quantity) x ")
                                    
                                    Text("\(Int(item.price)) = ")
                                    + Text("₹\(Int(item.price * Double(item.quantity)))"
                                    )
                                }
                            }
                            
                            // total amount for all items
                            Text("Total Amount: ₹\(Int(order.totalAmount))")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("Orders")
        }
        .onAppear {
            // load orders from firestore
            viewModel.loadOrders()
        }
    }
}
