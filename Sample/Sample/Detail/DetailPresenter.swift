//
//  DetailPresenter.swift
//  MVP-Sample
//
//  Created by 손창우 on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

class DetailPresenter {
    private weak var viewDelegate: DetailViewDelegate?

    func attachView(view: DetailViewDelegate) {
        self.viewDelegate = view
    }
    
    func viewDidLoad() {
        DetailService.getItems { [weak self] result in
            switch result {
            case .success(let value):
                self?.viewDelegate?.loadFinished(datas: value)
            case .failure(let error):
                print(error.localizedDescription)
                self?.viewDelegate?.loadFailed()
            }
        }
    }
}
