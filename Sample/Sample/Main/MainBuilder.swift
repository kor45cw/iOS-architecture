//
//  MainBuilder.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency>, NetworkDependency {
    var networkViewController: NetworkViewControllable {
        return mainViewController
    }
    
    let mainViewController: MainViewController
    
    init(dependency: MainDependency, viewController: MainViewController) {
        self.mainViewController = viewController
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> (router: MainRouting, item: MainActionableItem)
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> (router: MainRouting, item: MainActionableItem) {
        let viewController = MainViewController.instance()
        let component = MainComponent(dependency: dependency, viewController: viewController)
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        
        let networkBuilder = NetworkBuilder(dependency: component)
        let router = MainRouter(interactor: interactor,
                          viewController: viewController,
                          networkBuilder: networkBuilder)
        return (router, interactor)
    }
}
