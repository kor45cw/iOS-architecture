//
//  SuccessBuilder.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol SuccessDependency: Dependency {
    var retryStream: RetryStream { get }
}

final class SuccessComponent: Component<SuccessDependency> {

    fileprivate var retryStream: RetryStream {
        return dependency.retryStream
    }
    
    let items: [Post]
    
    init(dependency: SuccessDependency,
         items: [Post]) {
        self.items = items
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SuccessBuildable: Buildable {
    func build(withListener listener: SuccessListener, items: [Post]) -> SuccessRouting
}

final class SuccessBuilder: Builder<SuccessDependency>, SuccessBuildable {

    override init(dependency: SuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuccessListener,
               items: [Post]) -> SuccessRouting {
        let component = SuccessComponent(dependency: dependency, items: items)
        let viewController = SuccessViewController.instance(items: component.items)
        let interactor = SuccessInteractor(presenter: viewController,
                                           retryStream: component.retryStream)
        interactor.listener = listener
        return SuccessRouter(interactor: interactor, viewController: viewController)
    }
}
