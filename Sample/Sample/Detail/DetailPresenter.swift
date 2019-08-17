//
//  DetailPresenter.swift
//  Sample
//
//  Created by kor45cw on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresenterDelegate {
    weak var view: DetailViewDelegate!
    
    private var posts: [Post] = []
    
    init(view: DetailViewDelegate) {
        self.view = view
    }
    
    var numberOfItemsInSection: Int {
        return posts.count
    }
    
    subscript(indexPath: IndexPath) -> Post? {
        guard indexPath.section == 0 else { return nil }
        return posts[safe: indexPath.item]
    }
    
    func fetchDatas() {
        DetailService.getItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.posts = posts
                self.view.loadFinished()
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
        }
    }
}
