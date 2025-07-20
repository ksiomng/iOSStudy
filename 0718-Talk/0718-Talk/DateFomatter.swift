//
//  DateFomatter.swift
//  0718-Talk
//
//  Created by Song Kim on 7/20/25.
//

import UIKit

class DateFomatter {
    static func formatChatTimestamp(_ input: String, type: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")

        let date = formatter.date(from: input)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}
