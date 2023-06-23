//
//  WebService.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import Foundation

class WebService {
    func getProducts(url: URL, completion: @escaping ([Product]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let result = try? JSONDecoder().decode(Starter.self, from: data)

                if let result = result {
                    completion(result)
                }
            }
        }.resume()
    }
}
