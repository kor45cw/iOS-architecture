//
//  NormalMainPresenter.swift
//  Viper-Sample
//
//  Created by 손창우 on 01/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class NormalMainPresenter: NormalMainPresenterProtocol {
    weak var view: NormalMainViewProtocol!
    var interactor: NormalMainInteractorInputProtocol!
    var router: NormalMainRouterProtocol!
    
    func viewDidLoad() {
        interactor.fetchDatas()
    }
    
    var numberOfRowsInSection: Int {
        return interactor.datas.count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> MainData? {
        return interactor.datas[indexPath.item]
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        router.presentPostDetailScreen(for: interactor.datas[indexPath.item])
    }
}

extension NormalMainPresenter: NormalMainInteractorOutputProtocol {
    func loadOnError() {
        // Error
    }
    
    func loadFinished() {
        view.loadFinished()
    }
}
