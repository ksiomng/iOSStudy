//
//  NetworkRouter.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/13/25.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case searchShop(name: String, itemCount: Int, page: Int, sort: String)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/shop.json"
    }
    
    var endPoint: URL {
        switch self {
        case .searchShop(let name, let itemCount, let page, let sort):
            URL(string: "\(baseURL)?query=\(name)&display=\(itemCount)&start=\(page)&sort=\(sort)")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return [
            "X-Naver-Client-Id" : APIKey.naverClientId,
            "X-Naver-Client-Secret" : APIKey.naverSecret
        ]
    }
}
