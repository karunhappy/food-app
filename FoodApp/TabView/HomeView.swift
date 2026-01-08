//
//  HomeView.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    @Binding var selectedTab : Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Display items
                LazyVStack(spacing: 12) {
                    ForEach($viewModel.items) { $item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                // item name
                                Text(item.name)
                                    .font(.headline)
                                // item price
                                Text("₹\(Int(item.price))")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                // minus (decrement) button
                                Button {
                                    viewModel.decrement(item)
                                    viewModel.persistCart(using: modelContext)
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .font(.title2)
                                }
                                // item quantity
                                Text("\(item.quantity)")
                                    .frame(minWidth: 24)
                                    // plus (increment) button
                                Button {
                                    viewModel.increment(item)
                                    viewModel.persistCart(using: modelContext)
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .font(.title2)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .background(Color(.systemBackground))
                        
                        Divider()
                    }
                }
                .navigationTitle("Foodies World")
                .navigationSplitViewStyle(.automatic)
            }
            // display bottom bar to show total items & amount
            if viewModel.showBottombar {
                bottombar
            }
        }
    }
    
    private var bottombar: some View {
        Button {
            // action - navigate to cart screen and reset cart
            selectedTab = 1
            viewModel.resetCart()
        } label: {
            HStack {
                Text("Add To Cart - ").padding(.leading, 10)
                Text("\(viewModel.totalItems) Items")
                Spacer()
                Text("₹\(Int(viewModel.totalPrice))")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(12)
            .padding()
        }

    }
}
