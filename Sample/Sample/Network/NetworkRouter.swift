//
//  NetworkRouter.swift
//  Sample
//
//  Created by kor45cw on 01/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol NetworkInteractable: Interactable, SuccessListener, FailureListener {
    var router: NetworkRouting? { get set }
    var listener: NetworkListener? { get set }
}

protocol NetworkViewControllable: ViewControllable {
    func push(viewController: ViewControllable)
    func pop(viewController: ViewControllable)
}

final class NetworkRouter: Router<NetworkInteractable>, NetworkRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: NetworkInteractable,
         viewController: NetworkViewControllable,
         successBuilder: SuccessBuildable,
         failureBuilder: FailureBuildable) {
        self.viewController = viewController
        self.successBuilder = successBuilder
        self.failureBuilder = failureBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.pop(viewController: currentChild.viewControllable)
        }
    }
    
    func routeToSuccess(items: [Post]) {
        detachCurrentChild()
        let success = successBuilder.build(withListener: interactor, items: items)
        currentChild = success
        attachChild(success)
        viewController.push(viewController: success.viewControllable)
    }
    
    func routeToFailure(error: Error) {
        detachCurrentChild()
        let failure = failureBuilder.build(withListener: interactor, error: error)
        currentChild = failure
        attachChild(failure)
        viewController.push(viewController: failure.viewControllable)
    }
    
    // MARK: - Private

    private let viewController: NetworkViewControllable
    private let successBuilder: SuccessBuildable
    private let failureBuilder: FailureBuildable
    private var currentChild: ViewableRouting?
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.pop(viewController: currentChild.viewControllable)
        }
    }
}
