//
//  CartView.swift
//  FoodApp
//
//  Created by Karun Aggarwal on 04/01/26.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = CartViewModel()
    
    @State private var checkout: Bool = false
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.cartItems.isEmpty {
                    Text("Cart is empty")
                        .foregroundStyle(Color.gray)
                } else {
                    ScrollView {
                        HStack(spacing: 12) {
                            VStack(spacing: 16) {
                                // load cart items
                                ForEach(viewModel.cartItems) { item in
                                    HStack {
                                        Text(item.name)
                                        Spacer()
                                        
                                        Button {
                                            viewModel.decrement(item)
                                        } label: {
                                            Image(systemName: "minus.circle")
                                        }
                                        
                                        Text("\(item.quantity) x ")
                                        
                                        Button {
                                            viewModel.increment(item)
                                        } label: {
                                            Image(systemName: "plus.circle")
                                        }
                                        
                                        Text(
                                            "₹\(Int(item.price * Double(item.quantity)))"
                                        )
                                        
                                        Button {
                                            viewModel.delete(item)
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            
                        }
                        Divider()
                        // check out button
                        Button {
                            withAnimation(.easeInOut) {
                                checkout.toggle()
                            }

                        } label: {
                            Text(checkout ? "Cancel" : "Check out")
                                .frame(maxWidth: .infinity)
                        }
                        
                        if checkout {
                            // user detail form
                            VStack(spacing: 12) {
                                TextField("Name", text: $name)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(height: 50)
                                TextField("Phone number", text: $phone)
                                    .keyboardType(.phonePad)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(height: 50)
                                if isLoading {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                } else {
                                    Button {
                                        placeOrder()
                                    } label: {
                                        Text("Order Now")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(
                                                isFormValid ? Color.green : Color.gray
                                            )
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .disabled(!isFormValid)
                                }
                                
                            }
                            .padding(.horizontal, 16)
                            .transition(
                                .move(edge: .bottom).combined(with: .opacity)
                            )
                        }
                    }
                }
                
            }.navigationTitle("Cart")
        }
        .onAppear {
            viewModel.configure(context: modelContext)
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && phone.count >= 10
    }
    
    private func placeOrder() {
        print("Order placed by \(name), \(phone)")
        viewModel.submitOrder(name: name, phone: phone) { status in
            isLoading = false
            if status {
                name = ""
                phone = ""
                checkout = false
            }
        }
    }
}
