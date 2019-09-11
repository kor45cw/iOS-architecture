//
//  MainInteractor.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToNetwork(type: MainEntity)
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MainListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>,
                        MainInteractable, MainPresentableListener, MainActionableItem {

    weak var router: MainRouting?
    weak var listener: MainListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MainPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func tableView(didSelectRowAt item: MainEntity) {
        router?.routeToNetwork(type: item)
    }
    
    func waitForNetwork(item: (entity: MainEntity, status: Bool)) -> Observable<(MainActionableItem, ())> {
        router?.routeToNetwork(type: item.entity)
        return Observable.just((self, ()))
    }
    
}
