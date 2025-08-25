//
//  ChangeNameViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ChangeNameViewModel {
    
    struct Input {
        let name: ControlProperty<String>
    }
    
    struct Output {
        let stateString: PublishSubject<String>
        let isValid: BehaviorSubject<Bool>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let state = PublishSubject<String>()
        let isValid = BehaviorSubject<Bool>(value: false)
        
        input.name
            .bind(with: self) { owner, text in
                let valid = (2...8).contains(text.count)
                isValid.onNext(valid)
                state.onNext(valid ? "사용가능한 닉네임입니다" : "2자 이상 8자 이하로 입력해주세요")
            }
            .disposed(by: disposeBag)
        return Output(stateString: state, isValid: isValid)
    }
}
