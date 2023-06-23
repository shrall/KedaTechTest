//
//  ProductDetailViewModelTests.swift
//  KedaTechTestTests
//
//  Created by Marshall Kurniawan on 24/06/23.
//
import XCTest
@testable import KedaTechTest

final class ProductDetailViewModelTests: XCTestCase {
    
    var viewModel: ProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ProductDetailViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testToggleFavorite() {
        let expectation = XCTestExpectation(description: "Toggle favorite state")
        let productId = 123
        
        viewModel.isFavorite = false
        
        viewModel.toggleFavorite(productId)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.isFavorite)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
}
