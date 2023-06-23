//
//  FavoriteProductListView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 24/06/23.
//

import SwiftUI

struct FavoriteProductListView: View {
    @StateObject private var favoriteProductListVM = FavoriteProductListViewModel()

    var filteredProducts: [FavoritedProduct] {
        if favoriteProductListVM.searchText.isEmpty {
            return favoriteProductListVM.favoritedProducts
        } else {
            return favoriteProductListVM.favoritedProducts.filter { $0.title!.lowercased().contains(favoriteProductListVM.searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Text("You have no favorites.")
                    .opacity(favoriteProductListVM.favoritedProducts.count > 0 ? 0 : 1)
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 160))
                    ], spacing: 20) {
                        ForEach(filteredProducts, id: \.self) { product in
                            NavigationLink {
                                ProductDetailView(productID: Int(product.id))
                                    .onDisappear{
                                        favoriteProductListVM.getAllProducts()
                                    }
                            } label: {
                                VStack {
                                    ProductCard(image: product.image!, title: product.title!, category: product.category!, price: product.price)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Favorites")
        }
        .searchable(text: $favoriteProductListVM.searchText)
        .onAppear{
            favoriteProductListVM.getAllProducts()
        }
    }
}
