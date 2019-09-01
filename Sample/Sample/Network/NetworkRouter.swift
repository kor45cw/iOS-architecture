//
//  NetworkRouter.swift
//  Sample
//
//  Created by kor45cw on 01/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol NetworkInteractable: Interactable {
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
         viewController: NetworkViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.pop(viewController: currentChild.viewControllable)
        }
    }
    
    func routeToSuccess() {
        
    }
    
    func routeToFailure() {
        
    }
    
    // MARK: - Private

    private let viewController: NetworkViewControllable
    private var currentChild: ViewableRouting?
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.pop(viewController: currentChild.viewControllable)
        }
    }
}
