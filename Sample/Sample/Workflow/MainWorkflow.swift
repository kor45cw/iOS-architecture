//
//  MainWorkflow.swift
//  Sample
//
//  Created by kor45cw on 11/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs
import RxSwift

class MainWorkflow: Workflow<RootActionableItem> {
    init(shortcutItem: UIApplicationShortcutItem) {
        super.init()
        
        let entity = parseEntity(from: shortcutItem)
        
        self.onStep { (rootItem) -> Observable<(MainActionableItem, (entity: MainEntity, status: Bool))> in
            rootItem.waitForMain(item: entity)
        }.onStep { (mainItem, item) -> Observable<(MainActionableItem, ())> in
            mainItem.waitForNetwork(item: item)
        }
        .commit()
    }
    
    private func parseEntity(from shortcutItem: UIApplicationShortcutItem) -> (entity: MainEntity, status: Bool) {
        let item = SampleShortcutItem(item: shortcutItem)
        switch item {
        case .getSuccess:
            return (.get, true)
        case .getFailure:
            return (.get, false)
        }
    }
}
