//
//  ProductListView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productListVM = ProductListViewModel()

    var filteredProducts: [Product] {
        if productListVM.searchText.isEmpty {
            return productListVM.products
        } else {
            return productListVM.products.filter { $0.title.lowercased().contains(productListVM.searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ProgressView()
                    .opacity(productListVM.products.count > 0 ? 0 : 1)
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 160))
                    ], spacing: 20) {
                        ForEach(filteredProducts, id: \.self) { product in
                            NavigationLink {
                                ProductDetailView(productID: product.id)
                                    .onDisappear{
                                        productListVM.getAllProducts()
                                    }
                            } label: {
                                VStack {
                                    ProductCard(image: product.image, title: product.title, category: product.category, price: product.price)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Products")
        }
        .searchable(text: $productListVM.searchText)
        .onAppear{
            productListVM.getAllProducts()
        }
    }
}
