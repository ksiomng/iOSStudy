//
//  NetworkManager.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/29/25.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchShopDate(name: String, sort: String, page: Int, itemCount: Int, success: @escaping (Shops) -> Void, fail: @escaping (Int?) -> Void) {
        let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(name)&display=\(itemCount)&start=\(page)&sort=\(sort)")!
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverClientId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300) //
            .responseDecodable(of: Shops.self) { response in
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let err):
                    fail(err.responseCode)
                }
            }
    }
}
