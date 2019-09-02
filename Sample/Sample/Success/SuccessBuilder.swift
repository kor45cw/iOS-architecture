//
//  SuccessBuilder.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol SuccessDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SuccessComponent: Component<SuccessDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuccessBuildable: Buildable {
    func build(withListener listener: SuccessListener) -> SuccessRouting
}

final class SuccessBuilder: Builder<SuccessDependency>, SuccessBuildable {

    override init(dependency: SuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuccessListener) -> SuccessRouting {
        let component = SuccessComponent(dependency: dependency)
        let viewController = SuccessViewController()
        let interactor = SuccessInteractor(presenter: viewController)
        interactor.listener = listener
        return SuccessRouter(interactor: interactor, viewController: viewController)
    }
}
