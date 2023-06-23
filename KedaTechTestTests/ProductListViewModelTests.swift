//
//  ProductListViewModelTests.swift
//  KedaTechTestTests
//
//  Created by Marshall Kurniawan on 24/06/23.
//

import XCTest
@testable import KedaTechTest

final class ProductListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        //
    }
    
    override func tearDownWithError() throws {
        //
    }
    
    func testFetchCategories() {
        let expectation = XCTestExpectation(description: "Fetch categories expectation")

        let url = URL(string: "https://fakestoreapi.com/products")!

        WebService().getProducts(url: url) { products in
            if let products = products {
                XCTAssertNotNil(products)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
