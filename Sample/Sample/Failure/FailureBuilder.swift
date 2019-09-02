//
//  FailureBuilder.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol FailureDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FailureComponent: Component<FailureDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FailureBuildable: Buildable {
    func build(withListener listener: FailureListener, error: Error) -> FailureRouting
}

final class FailureBuilder: Builder<FailureDependency>, FailureBuildable {

    override init(dependency: FailureDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FailureListener,
               error: Error) -> FailureRouting {
        let component = FailureComponent(dependency: dependency)
        let viewController = FailureViewController.instance(error: error)
        let interactor = FailureInteractor(presenter: viewController)
        interactor.listener = listener
        return FailureRouter(interactor: interactor, viewController: viewController)
    }
}
