//
//  MainRouter.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol MainInteractable: Interactable, NetworkListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    func push(viewController: ViewControllable)
    func pop(viewController: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MainInteractable,
         viewController: MainViewControllable,
         networkBuilder: NetworkBuildable) {
        self.networkBuilder = networkBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToNetwork(type: MainEntity) {
        let network = networkBuilder.build(withListener: interactor)
        attachChild(network)
    }
    
    private let networkBuilder: NetworkBuildable
}
