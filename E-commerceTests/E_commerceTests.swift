//
//  E_commerceTests.swift
//  E-commerceTests
//
//  Created by Omar on 01/03/2023.
//

import XCTest
@testable import E_commerce

final class E_commerceTests: XCTestCase {
    
    let ViewModel = OrderViewModel()
    
    var brandViewModel : HomeViewModel?
    var categoryViewModel : CategoryViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        brandViewModel = HomeViewModel()
        categoryViewModel = CategoryViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        brandViewModel = nil
        categoryViewModel = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testGetAddress(){
        let myExpectation = expectation(description: "wating for get Shopping cart order response")
        ViewModel.getAllItems { OrderList, error in
            if error != nil {
                XCTFail()
            } else
            {
                XCTAssertNotNil(OrderList)
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    //    func testDeleteAddress(){
    //        let myExpectation = expectation(description: "wating for delete wishList product for selected customer response")
    //        let orderList = OrderListModel(context: context)
    //        orderList.itemID = 2
    //        orderList.userID = 2
    //        orderList.itemName = ""
    //        orderList.itemPrice = ""
    //        orderList.itemImage = ""
    //
    //        ViewModel.deleteItem(item: orderList)
    //            if ViewModel.deleteItem(item: orderList) {
    //                XCTFail()
    //            } else
    //            {
    //                XCTAssertNotNil(orderList)
    //                myExpectation.fulfill()
    //            }
    //        }
    //        waitForExpectations(timeout: 5, handler: nil)
    //    }
    
    func testgetAllBrands(){
        
        let exp = expectation(description: "wating for API...")
        
        brandViewModel?.getAllBrands()
        brandViewModel?.bindingBrands = {
            if let data : Brands = self.brandViewModel?.ObservableBrands {
                XCTAssertNotNil(data)
                exp.fulfill()
            }else{
                XCTFail()
            }
            
        }
        waitForExpectations(timeout: 5)
    }
    
    func testgetProductsCategory(){
        let exp = expectation(description: "wating for API...")
        
        categoryViewModel?.getProductsCategory(url: "https://12cda6f78842e3d15dd501d7e1fbc322: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@mad-ios1.myshopify.com/admin/api/2023-01/products.json?collection_id=438822437163")
        categoryViewModel?.bindingProductsCategory = { data in
            if let product : product = data {
                XCTAssert(product.products.count == 3, "fail number of product in kid category equal 3")
                exp.fulfill()
            }else{
                XCTFail()
            }
            
        }
        waitForExpectations(timeout: 5)
    }
    
    
}
