//
//  NormalDetailPresenter.swift
//  Sample
//
//  Created by kor45cw on 04/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

class NormalDetailPresenter: NormalDetailPresenterProtocol {
    weak var view: NormalDetailViewProtocol!
    var interactor: NormalDetailInteractorInputProtocol!
    var router: NormalDetailRouterProtocol!
    
    func viewDidLoad() {
        interactor.fetchDatas()
    }
    
    var numberOfRowsInSection: Int {
        interactor.items.count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> Post? {
        return interactor.items[indexPath.item]
    }
}

extension NormalDetailPresenter: NormalDetailInteractorOutputProtocol {
    func loadOnError() {
        view.showError()
    }
    
    func loadFinished() {
        view.updateData()
    }
}
