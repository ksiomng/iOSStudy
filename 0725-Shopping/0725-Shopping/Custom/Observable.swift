//
//  Observable.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

class Observable<T> {
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping (T) -> Void) {
        action(value)
        self.action = action
    }
    
    func lazyBind(action: @escaping (T) -> Void) {
        self.action = action
    }
}
