//
//  APIKey.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/25/25.
//

import Foundation

class APIKey {
    private init() { }
    
    static let naverClientId = Bundle.main.infoDictionary?["NaverClientId"] as! String
    static let naverSecret = Bundle.main.infoDictionary?["NaverClientSecret"] as! String
}
