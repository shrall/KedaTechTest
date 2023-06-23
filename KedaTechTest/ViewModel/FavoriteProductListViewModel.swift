//
//  FavoriteProductListViewModel.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 24/06/23.
//

import Foundation
import CoreData

class FavoriteProductListViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var searchText: String = ""
    @Published var favoritedProducts: [FavoritedProduct] = []

    func getAllProducts() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritedProduct")
        do {
            favoritedProducts = try viewContext.fetch(fetchRequest) as! [FavoritedProduct]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
