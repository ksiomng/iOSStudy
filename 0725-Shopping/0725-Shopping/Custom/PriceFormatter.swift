//
//  PriceFormatter.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import Foundation

class PriceFormatter {
    private init() { }
    
    static let shared: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
