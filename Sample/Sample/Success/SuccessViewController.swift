//
//  SuccessViewController.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SuccessPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SuccessViewController: UIViewController, SuccessPresentable, SuccessViewControllable {

    weak var listener: SuccessPresentableListener?
}
