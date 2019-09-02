//
//  UINavigation+RIBs.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit
import RIBs

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }

    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}


