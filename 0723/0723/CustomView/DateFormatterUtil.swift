//
//  DateFormatterUtil.swift
//  0723
//
//  Created by Song Kim on 7/23/25.
//


import Foundation

class SongDateFormatter {
    static func dateFormat(_ input: String) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMdd"
        let stirngDate = myFormatter.date(from: input)
        
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: stirngDate!)
        return dateString
    }
}
