//
//  WordViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class WordCounterViewModel {
    func updateText(_ text: String) -> String {
        let count = text.count
        return "현재까지 \(count)글자 작성중"
    }
}
