//
//  MainViewController.swift
//  MVP-Sample
//
//  Created by 손창우 on 02/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

protocol MainViewDelegate: class {
    func show(datas: [MainEntity])
}

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private var presenter = MainPresenter()
    private var datas: [MainEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.loadDatas()
    }
}

extension MainViewController: MainViewDelegate {
    func show(datas: [MainEntity]) {
        self.datas = datas
        self.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.item].rawValue
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
}
