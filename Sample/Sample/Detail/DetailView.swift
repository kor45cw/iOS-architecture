//
//  DetailView.swift
//  Sample
//
//  Created by kor45cw on 17/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    static func instance() -> DetailView {
        let vc: DetailView = instance(storyboardName: .main)
        vc.presenter = DetailPresenter(view: vc)
        return vc
    }
    
    var presenter: DetailPresenterDelegate!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchDatas()
    }
}

extension DetailView: DetailViewDelegate {
    func loadFinished() {
        self.tableView.reloadData()
    }
}

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter[indexPath]?.title
        return cell
    }
}

extension DetailView: UITableViewDelegate {
    
}
