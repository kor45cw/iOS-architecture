//
//  RootBuilder.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, shortcutHandler: ShortcutHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (launchRouter: LaunchRouting, shortcutHandler: ShortcutHandler) {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        
        let mainBuilder = MainBuilder(dependency: component)
        let router = RootRouter(interactor: interactor,
                          viewController: viewController,
                          mainBuilder: mainBuilder)
        return (router, interactor)
    }
}
