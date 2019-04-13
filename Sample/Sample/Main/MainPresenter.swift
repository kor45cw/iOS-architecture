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

class MainPresenter {
    private weak var viewDelegate: MainViewDelegate?
    
    func attachView(view: MainViewDelegate) {
        self.viewDelegate = view
    }
    
    func loadDatas() {
        viewDelegate?.show(datas: MainEntity.allCases)
    }
}
