//
//  RootRouter.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let mainBuilder: MainBuildable
    private var main: ViewableRouting?
    
    init(interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuilder: MainBuildable) {
        
        self.mainBuilder = mainBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToMain()
    }
    
    func routeToMain() {
        let main = mainBuilder.build(withListener: interactor)
        self.main = main
        attachChild(main)
        viewController.present(viewController: main.viewControllable)
    }
}
