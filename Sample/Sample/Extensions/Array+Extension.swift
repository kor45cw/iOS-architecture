//
//  Array+Extension.swift
//  Sample
//
//  Created by kor45cw on 17/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
