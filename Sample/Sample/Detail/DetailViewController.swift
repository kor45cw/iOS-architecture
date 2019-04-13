//
//  DetailViewController.swift
//  MVP-Sample
//
//  Created by 손창우 on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func loadFinished(datas: [Post])
    func loadFailed()
}

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let presenter = DetailPresenter()
    private var datas: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
}

extension DetailViewController: DetailViewDelegate {
    func loadFinished(datas: [Post]) {
        self.datas = datas
        tableView.reloadData()
    }
    
    func loadFailed() {
        self.datas = []
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.item].title
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
}
