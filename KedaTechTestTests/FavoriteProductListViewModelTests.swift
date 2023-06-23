//
//  FavoriteProductListViewModelTests.swift
//  KedaTechTestTests
//
//  Created by Marshall Kurniawan on 24/06/23.
//
import XCTest
import CoreData
@testable import KedaTechTest

final class FavoriteProductListViewModelTests: XCTestCase {
    var mockContext: NSManagedObjectContext!
    var viewModel: FavoriteProductListViewModel!
    
    override func setUp() {
        super.setUp()
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        mockContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mockContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        viewModel = FavoriteProductListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        mockContext = nil
        viewModel = nil
    }
    
    func testGetAllProducts() {
        let expectation = XCTestExpectation(description: "Fetch all favorited products")
        
        let favoritedProduct1 = FavoritedProduct(context: mockContext)
        favoritedProduct1.id = Int16(1)
        favoritedProduct1.title = "Product 1"
        favoritedProduct1.category = "Men's"
        favoritedProduct1.price = 10.2
        favoritedProduct1.image = "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"
        
        do {
            try mockContext.save()
            
            viewModel.getAllProducts()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                XCTAssertEqual(self.viewModel.favoritedProducts.count, 1)
                
                expectation.fulfill()
            }
        } catch {
            XCTFail("Failed to save favorited products: \(error)")
        }
        
        wait(for: [expectation], timeout: 3)
    }
}
