//
//  WordViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class WordCounterViewModel {
    
    var inputText = Field("")
    var outputText = Field("")
    
    init() {
        inputText.playAction { _ in
            self.updateText()
        }
    }
    
    private func updateText() {
        let count = inputText.value.count
        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
