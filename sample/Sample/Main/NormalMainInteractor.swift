//
//  NormalMainInteractor.swift
//  Sample
//
//  Created by kor45cw on 01/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class NormalMainInteractor: NormalMainInteractorInputProtocol {
    weak var presenter: NormalMainInteractorOutputProtocol?
    
    var datas: [MainData] = []
    
    func fetchDatas() {
        // Load Data
        self.datas = MainData.allCases
        presenter?.loadFinished()
    }
}
