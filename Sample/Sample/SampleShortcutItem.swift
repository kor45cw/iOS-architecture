//
//  SampleShortcutItem.swift
//  Sample
//
//  Created by kor45cw on 11/09/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

enum SampleShortcutItem: CaseIterable {
    case getSuccess
    case getFailure
    
    init(item: UIApplicationShortcutItem) {
        switch item.type {
        case "GSAction": self = .getSuccess
        case "GFAction": self = .getFailure
        default: self = .getSuccess
        }
    }
    
    var type: String {
        switch self {
        case .getSuccess: return "GSAction"
        case .getFailure: return "GFAction"
        }
    }
    
    var localizedTitle: String {
        switch self {
        case .getSuccess: return "GET S"
        case .getFailure: return "GET F"
        }
    }
    
    var icon: UIApplicationShortcutIcon {
        switch self {
        case .getSuccess: return UIApplicationShortcutIcon(type: .bookmark)
        case .getFailure: return UIApplicationShortcutIcon(type: .home)
        }
    }
}
