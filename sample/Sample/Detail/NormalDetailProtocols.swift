//
//  NormalDetailProtocols.swift
//  Sample
//
//  Created by kor45cw on 04/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

protocol NormalDetailPresenterProtocol: class {
    var view: NormalDetailViewProtocol! { get set }
    var interactor: NormalDetailInteractorInputProtocol! { get set }
    var router: NormalDetailRouterProtocol! { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    var numberOfRowsInSection: Int { get }
    func cellForRowAt(_ indexPath: IndexPath) -> Post?
}

protocol NormalDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func loadFinished()
    func loadOnError()
}

protocol NormalDetailInteractorInputProtocol: class {
    var presenter: NormalDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: NormalDetailRemoteDataManagerInputProtocol? { get set }
    var items: [Post] { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchDatas()
}

protocol NormalDetailViewProtocol: class {
    var presenter: NormalDetailPresenterProtocol! { get set }
    
    // PRESENTER -> VIEW
    func updateData()
    func showError()
}

protocol NormalDetailRouterProtocol {
    var view: UIViewController! { get set }
    init(view: UIViewController)

    static func createModule() -> UIViewController
    
    // PRESENTER -> Router
}

protocol NormalDetailRemoteDataManagerInputProtocol {
    func request(completionHandler: @escaping (Result<[Post], Error>) -> Void)
}


