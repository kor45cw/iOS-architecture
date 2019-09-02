//
//  NetworkBuilder.swift
//  Sample
//
//  Created by kor45cw on 01/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

protocol NetworkDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var networkViewController: NetworkViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class NetworkComponent: Component<NetworkDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var networkViewController: NetworkViewControllable {
        return dependency.networkViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol NetworkBuildable: Buildable {
    func build(withListener listener: NetworkListener) -> NetworkRouting
}

final class NetworkBuilder: Builder<NetworkDependency>, NetworkBuildable {

    override init(dependency: NetworkDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NetworkListener) -> NetworkRouting {
        let component = NetworkComponent(dependency: dependency)
        let interactor = NetworkInteractor()
        interactor.listener = listener
        
        let successBuilder = SuccessBuilder(dependency: component)
        let failureBuilder = FailureBuilder(dependency: component)
        
        return NetworkRouter(interactor: interactor,
                             viewController: component.networkViewController,
                             successBuilder: successBuilder,
                             failureBuilder: failureBuilder)
    }
}
