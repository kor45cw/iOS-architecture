//
//  NormalDetailRemoteDataManager.swift
//  Sample
//
//  Created by kor45cw on 19/08/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import Alamofire

struct NormalDetailRemoteDataManager: NormalDetailRemoteDataManagerInputProtocol {
    func request(completionHandler: @escaping (Result<[Post], Error>) -> Void) {
        AF.request("http://jsonplaceholder.typicode.com/posts")
            .validate()
            .responseDecodable { (response: DataResponse<[Post]>) in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
