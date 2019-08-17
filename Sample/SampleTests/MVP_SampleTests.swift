//
//  MVP_SampleTests.swift
//  MVP-SampleTests
//
//  Created by 손창우 on 02/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import XCTest
@testable import Sample

class MVP_SampleTests: XCTestCase {
    var mainView: MockMainView!

    override func setUp() {
        super.setUp()
        mainView = MockMainView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testMain() {
        // When
        mainView.viewDidLoad()
        
        // Then
        XCTAssertEqual(mainView.numberOfItemsInSection, MainEntity.allCases.count)
    }
    
    func testSubscript() {
        XCTAssertNil(mainView.presenter[IndexPath(row: 0, section: 1)])
        XCTAssertNil(mainView.presenter[IndexPath(row: 6, section: 0)])
        XCTAssertEqual(mainView.presenter[IndexPath(row: 0, section: 0)], MainEntity.get)
    }
}

//there are the mock of UIviewController which using the Presenter
class MockMainView: MainViewDelegate {
    var presenter: MainPresenterDelegate!
    
    init() {
        self.presenter = MainPresenter(view: self)
    }
    
    public func viewDidLoad() {
        self.presenter.fetchDatas()
    }
    
    var numberOfItemsInSection = 0
    func loadFinished() {
        self.numberOfItemsInSection = presenter.numberOfItemsInSection
    }
}
