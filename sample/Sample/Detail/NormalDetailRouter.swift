//
//  NormalDetailRouter.swift
//  Sample
//
//  Created by kor45cw on 04/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class NormalDetailRouter: NormalDetailRouterProtocol {
    weak var view: UIViewController!
    
    required init(view: UIViewController) {
        self.view = view
    }
    
    static func createModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "NormalDetailView")
        guard let detailView = view as? NormalDetailView else {
            return UIViewController()
        }
        let presenter: NormalDetailPresenterProtocol & NormalDetailInteractorOutputProtocol = NormalDetailPresenter()
        let interactor: NormalDetailInteractorInputProtocol = NormalDetailInteractor()
        let remoteDataManager: NormalDetailRemoteDataManagerInputProtocol = NormalDetailRemoteDataManager()
        let router: NormalDetailRouterProtocol = NormalDetailRouter(view: detailView)
        
        detailView.presenter = presenter
        presenter.view = detailView
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        
        return detailView
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
