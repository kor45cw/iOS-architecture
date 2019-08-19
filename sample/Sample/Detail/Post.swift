//
//  Post.swift
//  Sample
//
//  Created by kor45cw on 19/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
