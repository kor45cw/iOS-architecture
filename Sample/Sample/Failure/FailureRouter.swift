//
//  FailureRouter.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol FailureInteractable: Interactable {
    var router: FailureRouting? { get set }
    var listener: FailureListener? { get set }
}

protocol FailureViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FailureRouter: ViewableRouter<FailureInteractable, FailureViewControllable>, FailureRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FailureInteractable, viewController: FailureViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
