//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class CurrencyViewModel {
    var inputAmount: Field<Double> = Field(0.0)
    var outputAmount = Field("")
    
    init() {
        inputAmount.playAction { _ in
            self.resultMessage()
        }
    }
    
    private func resultMessage() {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = inputAmount.value / exchangeRate
        outputAmount.value =  String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
