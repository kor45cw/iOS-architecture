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
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class NetworkRouter: Router<NetworkInteractable>, NetworkRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: NetworkInteractable, viewController: NetworkViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: NetworkViewControllable
}
