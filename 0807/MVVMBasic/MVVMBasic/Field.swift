//
//  Field.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class Field<T> {
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    init(_ text: T) {
        self.value = text
    }
    
    func playAction(action: @escaping (T) -> Void) {
        action(value)
        self.action = action
    }
}
