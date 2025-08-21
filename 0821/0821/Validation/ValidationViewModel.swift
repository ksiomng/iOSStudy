//
//  ValidationViewModel.swift
//  0821
//
//  Created by Song Kim on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class ValidationViewModel {
    
    struct Input {
        let username: ControlProperty<String>
        let password: ControlProperty<String>
        let buttonClick: ControlEvent<Void>
    }
    
    struct Output {
        let usernameState: BehaviorSubject<Bool>
        let passwordState: BehaviorSubject<Bool>
        let possibleState: Observable<Bool>
        let alertMessage: BehaviorSubject<String>
    }
    
    let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        let usernameState = BehaviorSubject(value: false)
        let passwordState = BehaviorSubject(value: false)
        let alertMessage = BehaviorSubject(value: "")

        input.username
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
            .bind(with: self) { owner, value in
                usernameState.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.password
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
            .bind(with: self) { owner, value in
                passwordState.onNext(value)
            }
            .disposed(by: disposeBag)
        
        let everythingValid = Observable.combineLatest(usernameState, passwordState) { $0 && $1 }
             .share(replay: 1)
        
        input.buttonClick
            .bind(with: self) { _, _ in
                alertMessage.onNext("This is wonderful")
            }
            .disposed(by: disposeBag)
        
        return Output(usernameState: usernameState, passwordState: passwordState, possibleState: everythingValid, alertMessage: alertMessage)
    }
}
