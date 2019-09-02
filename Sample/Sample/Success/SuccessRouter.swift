//
//  SuccessRouter.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol SuccessInteractable: Interactable {
    var router: SuccessRouting? { get set }
    var listener: SuccessListener? { get set }
}

protocol SuccessViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SuccessRouter: ViewableRouter<SuccessInteractable, SuccessViewControllable>, SuccessRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SuccessInteractable, viewController: SuccessViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
