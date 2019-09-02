//
//  FailureViewController.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol FailurePresentableListener: class {
    func retry()
}

final class FailureViewController: UIViewController, FailurePresentable, FailureViewControllable {
    static func instance(error: Error) -> FailureViewController {
        let vc: FailureViewController = instance(storyboardName: .main)
        vc.error = error
        return vc
    }
    
    private var error: Error?
    weak var listener: FailurePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = error?.localizedDescription
    }
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    @IBAction private func retry(_ sender: UIButton) {
        listener?.retry()
    }
}
