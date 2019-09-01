//
//  NetworkInteractor.swift
//  Sample
//
//  Created by kor45cw on 01/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

protocol NetworkRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
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
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}
