//
//  NormalDetailInteractor.swift
//  Sample
//
//  Created by kor45cw on 04/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation
import Alamofire

class NormalDetailInteractor: NormalDetailInteractorInputProtocol {
    weak var presenter: NormalDetailInteractorOutputProtocol?
    var remoteDatamanager: NormalDetailRemoteDataManagerInputProtocol?
    
    var items: [Post] = []
    
    func fetchDatas() {
        remoteDatamanager?.request { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.items = posts
                self.presenter?.loadFinished()
            case .failure(let error):
                print("ERROR", error.localizedDescription)
                self.presenter?.loadOnError()
            }
        }
    }
}
