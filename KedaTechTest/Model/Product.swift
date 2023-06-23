//
//  Product.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import Foundation

// MARK: - Product

struct Product: Codable, Hashable{
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(title)
      hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias Starter = [Product]
