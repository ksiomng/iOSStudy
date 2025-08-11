//
//  BirthViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

enum birthDayError: Error {
    case emptyString
    case isNotInt
    case year
    case month
    case day
}

class BirthViewModel {
    
    var inputYear = Field("")
    var inputMonth = Field("")
    var inputDay = Field("")
    var outputText = Field("")
    
    init() {
        inputYear.playAction { _ in
            self.resultMessage()
        }
        inputMonth.playAction { _ in
            self.resultMessage()
        }
        inputDay.playAction { _ in
            self.resultMessage()
        }
    }
    
    private func resultMessage() {
        do {
            let birthDate = try checkBirthDayError(year: inputYear.value, month: inputMonth.value, day: inputDay.value)
            let today = Date()
            let days = Calendar.current.dateComponents([.day], from: birthDate, to: today).day ?? 0
            outputText.value = "오늘은 \(days)일째입니다"
        } catch {
            switch error {
            case .emptyString:
                outputText.value =  "년 월 일 모두 입력해주세요"
            case .isNotInt:
                outputText.value =  "숫자를 입력해주세요"
            case .year:
                outputText.value =  "1000년부터 2025년까지 중에 입력해주세요"
            case .month:
                outputText.value =  "1월부터 12월중에 입력해주세요"
            case .day:
                outputText.value =  "월에 맞는 일수를 입력해주세요"
            }
        }
    }
    
    private func checkBirthDayError(year: String, month: String, day: String) throws(birthDayError) -> Date {
        guard !(year.isEmpty) && !(month.isEmpty) && !(day.isEmpty) else {
            throw .emptyString
        }
        guard Int(year) != nil && Int(month) != nil && Int(day) != nil else {
            throw .isNotInt
        }
        guard 1000 < Int(year)! && 2026 > Int(year)! else {
            throw .year
        }
        guard 0 < Int(month)! && Int(month)! <= 12 else {
            throw .month
        }
        guard 0 < Int(day)! && Int(day)! < checkDateRange(month: Int(month)!) else {
            throw .day
        }
        return stringToDate(year: year, month: month, day: day)
    }
    
    private func checkDateRange(month: Int) -> Int {
        if month == 4 || month == 6 || month == 9 || month == 11 {
            return 30
        } else if month == 2 {
            return 28
        } else {
            return 31
        }
    }
    
    private func stringToDate(year: String, month: String, day: String) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = Int(year)!
        dateComponents.month = Int(month)!
        dateComponents.day = Int(day)!
        
        let calendar = Calendar.current
        guard let birthDate = calendar.date(from: dateComponents) else {
            return Date()
        }
        return birthDate
    }
}
