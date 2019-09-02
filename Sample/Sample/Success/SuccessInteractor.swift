//
//  SuccessInteractor.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

protocol SuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuccessPresentable: Presentable {
    var listener: SuccessPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuccessListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SuccessInteractor: PresentableInteractor<SuccessPresentable>, SuccessInteractable, SuccessPresentableListener {

    weak var router: SuccessRouting?
    weak var listener: SuccessListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SuccessPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
