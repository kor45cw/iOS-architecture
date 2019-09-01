//
//  MainViewController.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func tableView(didSelectRowAt item: MainEntity)
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {
    static func instance() -> MainViewController {
        let vc: MainViewController = instance(storyboardName: .main)
        vc.items = MainEntity.allCases
        return vc
    }
    
    private var items: [MainEntity] = []

    weak var listener: MainPresentableListener?
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(MainTableViewCell.self)
            tableView.tableFooterView = UIView()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = items[indexPath.item].rawValue
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listener?.tableView(didSelectRowAt: items[indexPath.item])
    }
}

extension MainViewController: NetworkViewControllable {
    
}
