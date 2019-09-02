//
//  FailureInteractor.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

protocol FailureRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FailurePresentable: Presentable {
    var listener: FailurePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FailureListener: class {
    func retry()
}

final class FailureInteractor: PresentableInteractor<FailurePresentable>, FailureInteractable, FailurePresentableListener {

    weak var router: FailureRouting?
    weak var listener: FailureListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FailurePresentable) {
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
    
    func retry() {
        listener?.retry()
    }
}
