//
//  MainView.swift
//  Sample
//
//  Created by kor45cw on 17/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    static func instance() -> MainView {
        let vc: MainView = instance(storyboardName: .main)
        vc.presenter = MainPresenter(view: vc)
        return vc
    }
    
    var presenter: MainPresenterDelegate!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchDatas()
    }
}

extension MainView: MainViewDelegate {
    func loadFinished() {
        self.tableView.reloadData()
    }
}

extension MainView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter[indexPath]?.rawValue
        return cell
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailView.instance()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
