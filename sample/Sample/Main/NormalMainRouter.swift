//
//  NormalMainRouter.swift
//  Sample
//
//  Created by kor45cw on 01/03/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

class NormalMainRouter: NormalMainRouterProtocol {
    weak var view: UIViewController!
    
    required init(view: UIViewController) {
        self.view = view
    }
    
    class func createModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "NormalMainView")
        guard let mainView = view as? NormalMainView else {
            return UIViewController()
        }
        let presenter: NormalMainPresenterProtocol & NormalMainInteractorOutputProtocol = NormalMainPresenter()
        let interactor: NormalMainInteractorInputProtocol = NormalMainInteractor()
        let router: NormalMainRouterProtocol = NormalMainRouter(view: mainView)
        
        mainView.presenter = presenter
        presenter.view = mainView
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return mainView
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    func presentPostDetailScreen(for data: MainData) {
        let viewController = NormalDetailRouter.createModule()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
