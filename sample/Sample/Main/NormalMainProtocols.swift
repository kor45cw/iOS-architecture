//
//  NormalMainProtocols.swift
//  Sample
//
//  Created by kor45cw on 01/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

protocol NormalMainPresenterProtocol: class {
    var view: NormalMainViewProtocol! { get set }
    var interactor: NormalMainInteractorInputProtocol! { get set }
    var router: NormalMainRouterProtocol! { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    
    var numberOfRowsInSection: Int { get }
    func cellForRowAt(_ indexPath: IndexPath) -> MainData?
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol NormalMainInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func loadFinished()
    func loadOnError()
}

protocol NormalMainInteractorInputProtocol: class {
    var presenter: NormalMainInteractorOutputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func fetchDatas()
    
    var datas: [MainData] { get set }
}

protocol NormalMainViewProtocol: class {
    var presenter: NormalMainPresenterProtocol! { get set }

    // PRESENTER -> VIEW
    func loadFinished()
}

protocol NormalMainRouterProtocol: class {
    var view: UIViewController! { get set }
    
    static func createModule() -> UIViewController
    init(view: UIViewController)

    // PRESENTER -> Router
    func presentPostDetailScreen(for data: MainData)
}


