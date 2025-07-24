//
//  APIKey.swift
//  0723
//
//  Created by Song Kim on 7/24/25.
//

import Foundation

class APIKey {
    private init() { }
    
    static let movieKey = Bundle.main.infoDictionary?["movieAPIKey"] as! String
}
