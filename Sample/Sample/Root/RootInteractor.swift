//
//  RootInteractor.swift
//  Sample
//
//  Created by kor45cw on 07/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToMain() -> MainActionableItem
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>,
                            RootInteractable, RootPresentableListener, RootActionableItem, ShortcutHandler {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        let mainItem = router?.routeToMain()
        if let mainItem = mainItem {
            loggedInActionableItemSubject.onNext(mainItem)
        }
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    
    
    // MARK: - ShortcutHandler
    func application(performActionFor shortcutItem: UIApplicationShortcutItem) {
        let workflow = MainWorkflow(shortcutItem: shortcutItem)
        workflow
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }

    // MARK: - RootActionableItem

    func waitForMain(item:  (entity: MainEntity, status: Bool)) -> Observable<(MainActionableItem, (entity: MainEntity, status: Bool))> {
        return loggedInActionableItemSubject.map { mainItem -> (MainActionableItem, (entity: MainEntity, status: Bool )) in
            (mainItem, item)
        }
    }

    // MARK: - Private

    private let loggedInActionableItemSubject = ReplaySubject<MainActionableItem>.create(bufferSize: 1)
}
