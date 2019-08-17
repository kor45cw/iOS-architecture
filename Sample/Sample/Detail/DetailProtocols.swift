//
//  DetailProtocols.swift
//  Sample
//
//  Created by kor45cw on 17/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

protocol DetailViewDelegate: class {
    var presenter: DetailPresenterDelegate! { get set }
    func loadFinished()
}

protocol DetailPresenterDelegate: class {
    var view: DetailViewDelegate! { get set }
    var numberOfItemsInSection: Int { get }
    subscript(indexPath: IndexPath) -> Post? { get }
    func fetchDatas()
}
