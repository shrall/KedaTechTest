//
//  ProductDetailViewModel.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 24/06/23.
//

import CoreData
import Foundation

class ProductDetailViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var product = Product(id: 0, title: "", price: 0, description: "", category: "", image: "", rating: Rating(rate: 0, count: 0))
    @Published var isFavorite: Bool = false

    func getProduct(_ id: Int) {
        // Fetch product data
        let url = URL(string: "https://fakestoreapi.com/products/\(id)")!

        WebService().getProduct(url: url) { productResult in
            if let productResult = productResult {
                DispatchQueue.main.async {
                    self.product = productResult
                }
            }
        }
    }

    func checkFavorite(_ id: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritedProduct")
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: id))
        do {
            let favoritedProducts = try viewContext.fetch(fetchRequest)
            if favoritedProducts.count > 0 {
                isFavorite = true
            } else {
                isFavorite = false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func toggleFavorite(_ id: Int) {
        if isFavorite {
            do {
                let fetchRequest: NSFetchRequest<FavoritedProduct> = FavoritedProduct.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: id))
                let favoriteProducts = try viewContext.fetch(fetchRequest)
                if let favoritedProduct = favoriteProducts.first {
                    viewContext.delete(favoritedProduct)
                    isFavorite = false
                }
            } catch {
                // Handle the error appropriately
                print("Error fetching favorite products: \(error)")
            }
        } else {
            let favoriteProduct = FavoritedProduct(context: viewContext)
            favoriteProduct.id = Int16(id)
            favoriteProduct.title = product.title
            favoriteProduct.price = product.price
            favoriteProduct.category = product.category
            favoriteProduct.image = product.image
            isFavorite = true
        }
        save()
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
}
