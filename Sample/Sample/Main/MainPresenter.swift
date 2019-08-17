//
//  MainPresenter.swift
//  MVP-Sample
//
//  Created by 손창우 on 04/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

enum MainEntity: String, CaseIterable {
    case get
    case post
    case put
    case patch
    case delete
}

class MainPresenter: MainPresenterDelegate {
    weak var view: MainViewDelegate!
    
    init(view: MainViewDelegate) {
        self.view = view
    }
    
    var numberOfItemsInSection: Int {
        return MainEntity.allCases.count
    }
    
    subscript(indexPath: IndexPath) -> MainEntity? {
        guard indexPath.section == 0 else { return nil }
        return MainEntity.allCases[safe: indexPath.item]
    }
    
    func fetchDatas() {
        view.loadFinished()
    }
}
