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
    var mainViewController = MockUIViewController()
    let presenter = MainPresenter()

    override func setUp() {
        super.setUp()
        presenter.attachView(view: mainViewController)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMain() {
        // When
        presenter.loadDatas()
        
        // Then
        XCTAssertEqual(mainViewController.datas, MainEntity.allCases)
    }
}

//there are the mock of UIviewController which using the Presenter
class MockUIViewController: MainViewDelegate {
    var datas: [MainEntity] = []
    func show(datas: [MainEntity]) {
        self.datas = datas
    }
}
