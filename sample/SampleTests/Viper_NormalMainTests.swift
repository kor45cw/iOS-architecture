//
//  Viper_NormalMainTests.swift
//  SampleTests
//
//  Created by kor45cw on 10/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import XCTest
@testable import Sample

class NormalMainTests: XCTestCase {
    
    var interactor: NormalMainInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = NormalMainInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func testInteractor() {
        // When
        interactor.fetchDatas()
        
        // Then
        XCTAssertEqual(interactor.datas, MainData.allCases)
    }
}
