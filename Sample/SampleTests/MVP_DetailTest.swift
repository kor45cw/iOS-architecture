//
//  MVP_DetailTest.swift
//  MVP-SampleTests
//
//  Created by 손창우 on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import XCTest
@testable import Sample

class MVP_DetailTest: XCTestCase {
    var viewController: MockDetailViewController!
    let presenter = DetailPresenter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetail() {
        let expectation = self.expectation(description: "Scaling")
        viewController = MockDetailViewController(expectation: expectation)
        presenter.attachView(view: viewController)
        
        // When
        presenter.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(viewController.datas.first!.id, 1, "FIRST ITEM IS ALWAYS 1")
    }
}

//there are the mock of UIviewController which using the Presenter
class MockDetailViewController: DetailViewDelegate {
    let expectation: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    var datas: [Post] = []
    func loadFinished(datas: [Post]) {
        self.datas = datas
        expectation.fulfill()
    }
    
    func loadFailed() {
        
    }
}
