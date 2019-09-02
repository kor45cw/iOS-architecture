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
    static func instance(items: [Post]) -> SuccessViewController {
        let vc: SuccessViewController = instance(storyboardName: .main)
        vc.items = items
        return vc
    }
    
    weak var listener: SuccessPresentableListener?
    private var items: [Post] = []
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.register(MainTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Retry: \(count)"
    }
    
    private var count = 0
    func set(_ count: Int) {
        self.count = count
    }
}

extension SuccessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = items[indexPath.item].title
        return cell
    }
}
