//
//  NetworkManager.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/29/25.
//

import UIKit
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(api: NetworkRouter, type: T.Type, success: @escaping (T) -> Void, fail: @escaping (Int?) -> Void) {
        AF.request(api.endPoint, method: api.method, headers: api.header)
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
                fail(error.responseCode)
            }
        }
    }
}
