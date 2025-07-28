//
//  String+Extension.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/28/25.
//

import Foundation

extension String {
    var htmlStringChanged: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
