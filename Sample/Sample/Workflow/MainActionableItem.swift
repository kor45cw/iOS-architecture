//
//  MainActionableItem.swift
//  Sample
//
//  Created by kor45cw on 11/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RxSwift

protocol MainActionableItem: class {
    func waitForNetwork(item: (entity: MainEntity, status: Bool)) -> Observable<(MainActionableItem, ())>
}
