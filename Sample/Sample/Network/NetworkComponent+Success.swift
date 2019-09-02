//
//  NetworkComponent+Success.swift
//  Sample
//
//  Created by kor45cw on 02/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import RIBs

extension NetworkComponent: SuccessDependency {
    var retryStream: RetryStream {
        return mutableRetryStream
    }
}
