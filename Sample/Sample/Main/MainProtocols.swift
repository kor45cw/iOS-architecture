//
//  MainProtocols.swift
//  Sample
//
//  Created by kor45cw on 17/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

protocol MainViewDelegate: class {
    var presenter: MainPresenterDelegate! { get set }
    func loadFinished()
}

protocol MainPresenterDelegate: class {
    var view: MainViewDelegate! { get set }
    var numberOfItemsInSection: Int { get }
    subscript(indexPath: IndexPath) -> MainEntity? { get }
    func fetchDatas()
}
