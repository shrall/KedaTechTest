//
//  ProductListView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductListView: View {
    let navigationTitle: String
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
                                Text(product.title)
                            } label: {
                                VStack {
                                    ProductCard(product: product)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(navigationTitle)
        }
        .searchable(text: $productListVM.searchText)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(navigationTitle: "")
    }
}
