//
//  ProductListViewModel.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""

    init() {
        getAllProducts()
    }

    func getAllProducts() {
        // Fetch products
        let url = URL(string: "https://fakestoreapi.com/products")!

        WebService().getProducts(url: url) { productResults in
            if let productResults = productResults {
                DispatchQueue.main.async {
                    self.products = productResults
                }
            }
        }
    }
}
