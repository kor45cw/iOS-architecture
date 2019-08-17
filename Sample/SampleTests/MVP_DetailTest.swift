//
//  MVP_DetailTest.swift
//  SampleTests
//
//  Created by kor45cw on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import XCTest
@testable import Sample

class MVP_DetailTest: XCTestCase {
    var viewController: MockDetailView!
    
    override func setUp() {
        super.setUp()
        viewController = MockDetailView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetail() {
        let expectation = self.expectation(description: "Scaling")
        viewController.addExpectation(expectation: expectation)
        
        // When
        viewController.presenter.fetchDatas()
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(viewController.numberOfItemsInSection, 100)
        XCTAssertNil(viewController.presenter[IndexPath(row: 0, section: 1)])
        XCTAssertNil(viewController.presenter[IndexPath(row: 200, section: 0)])
        XCTAssertEqual(viewController.presenter[IndexPath(row: 0, section: 0)]?.id, 1)
    }
}

//there are the mock of UIviewController which using the Presenter
class MockDetailView: DetailViewDelegate {
    var presenter: DetailPresenterDelegate!
    var expectation: XCTestExpectation!
    
    init() {
        presenter = DetailPresenter(view: self)
    }
    
    func addExpectation(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    var numberOfItemsInSection = 0
    func loadFinished() {
        numberOfItemsInSection = presenter.numberOfItemsInSection
        expectation.fulfill()
    }
    
    func loadFailed() {
        
    }
}
