//
//  NormalMainInteractor.swift
//  Viper-Sample
//
//  Created by 손창우 on 01/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class NormalMainInteractor: NormalMainInteractorInputProtocol {
    weak var presenter: NormalMainInteractorOutputProtocol!
    
    var datas: [MainData] = []
    
    func fetchDatas() {
        // Load Data
        self.datas = MainData.allCases
        print("THIS IS INTERACTOR", self.datas.count)
        presenter.loadFinished()
    }
}
