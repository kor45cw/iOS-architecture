//
//  RootViewController.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    func push(viewController: ViewControllable) {
        pushViewController(viewController.uiviewController, animated: true)
    }
    
    func pop(viewController: ViewControllable) {
        if self.viewControllers.last == viewController.uiviewController {
            popViewController(animated: true)
        }
    }
}
