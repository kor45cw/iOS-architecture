//
//  DetailService.swift
//  MVP-Sample
//
//  Created by 손창우 on 05/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Foundation
import Alamofire

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

typealias GetCompletionHandler = (_ result: Result<[Post], Error>) -> Void

class DetailService {
    static func getItems(handler: @escaping GetCompletionHandler) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!
        AF.request(url, method: .get).validate().responseDecodable { (response: DataResponse<[Post]>) in
            handler(response.result)
        }
    }
}
