//
//  RetryStream.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


public protocol RetryStream: class {
    var retryCount: Observable<Int> { get }
}

public protocol MutableRetryStream: RetryStream {
    func increase()
}

class RetryStreamImpl: MutableRetryStream {
    var retryCount: Observable<Int> {
        return variable
            .asObservable()
            .distinctUntilChanged()
    }
    
    func increase() {
        variable.accept(variable.value + 1)
    }
    
    private let variable = BehaviorRelay<Int>(value: 0)
}
