//
//  NetworkInteractor.swift
//  Sample
//
//  Created by kor45cw on 01/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift
import Alamofire

protocol NetworkRouting: Routing {
    func cleanupViews()
    func routeToSuccess(items: [Post])
    func routeToFailure(error: Error)
}

protocol NetworkListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class NetworkInteractor: Interactor, NetworkInteractable {

    weak var router: NetworkRouting?
    weak var listener: NetworkListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // First fail
        getItems(urlString: "https://jsonplaceholder.typicode.com/po")
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }
    
    func getItems(urlString: String) {
        AF.request(urlString)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<[Post]>) in
                guard let self = self else { return }
                switch response.result {
                case .success(let posts):
                    self.router?.routeToSuccess(items: posts)
                case .failure(let error):
                    self.router?.routeToFailure(error: error)
                }
        }
    }
    
    func retry() {
        getItems(urlString: "https://jsonplaceholder.typicode.com/posts")
    }
}
