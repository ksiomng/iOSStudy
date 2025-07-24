//
//  SongDateFormatter.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//

import Foundation

class SongDateFormatter {
    
    private init() { }
    
    static func dateFormat(_ input: String) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMdd"
        let stringDate = myFormatter.date(from: input)
        
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let string = stringDate else {
            return "날짜형식이 맞지 않습니다"
        }
        let dateString = myFormatter.string(from: string)
        return dateString
    }
    
    static func yesterdayDateFormat() -> String {
        let today = Date()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMdd"
        let stringDate = myFormatter.string(from: yesterday)
        return stringDate
    }
}
