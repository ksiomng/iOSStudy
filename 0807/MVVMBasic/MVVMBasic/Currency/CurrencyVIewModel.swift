//
//  CurrencyVIewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class CurrencyVIewModel {
    func resultMessage(amount: Double) -> String {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        return String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
