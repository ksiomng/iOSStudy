//
//  DateFormatter.swift
//  0711
//
//  Created by Song Kim on 7/16/25.
//

import Foundation

class Date {
    static func dateFormatting(_ rawDate: String) -> String {
        let fullDateString = "20" + rawDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: fullDateString)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy년 MM월 dd일"
        let formatted = outputFormatter.string(from: date!)
        
        return formatted
    }
}
