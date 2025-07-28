//
//  Shop.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/26/25.
//

import Foundation

struct Shops: Decodable {
    let total: Int
    let items: [Shop]
}

struct Shop: Decodable {
    let image: String
    let brand: String
    let title: String
    let lprice: String
}
