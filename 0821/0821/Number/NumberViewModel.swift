//
//  NumberViewModel.swift
//  0821
//
//  Created by Song Kim on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class NumberViewModel {
    
    struct Input {
        let number1: ControlProperty<String>
        let number2: ControlProperty<String>
        let number3: ControlProperty<String>
    }
    
    struct Output {
        let total: BehaviorRelay<String> // BehaviorSubject
    }
    
    let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let result = BehaviorRelay(value: "")
        
        /*
        input.number1 // 1이 발생했을 때 2, 3이 같이 방출
            .withLatestFrom(input.number2)
            .withLatestFrom(input.number3)
         */
        Observable.combineLatest(input.number1, input.number2, input.number3) { text1, text2, text3 -> Int in
            return ((Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0))
        }
        .map { $0.description }
        .bind(with: self) { owner, value in
            result.accept(value) // BehaviorSubject 이면 onNext
        }
        .disposed(by: disposeBag)
        return Output(total: result)
    }
}
