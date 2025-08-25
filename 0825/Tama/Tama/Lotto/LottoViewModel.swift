//
//  LottoViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel {
    
    struct Input {
        let searchButton: ControlEvent<Void>
        let query: ControlProperty<String?>
    }
    
    struct Output {
        let lotto: BehaviorRelay<[Lotto]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let output = BehaviorRelay<[Lotto]>(value: [])
        
        input.searchButton
            .withLatestFrom(input.query.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                LottoObservable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, lotto in
                print("onNext", lotto)
                var data = output.value
                data.insert(lotto, at: 0)
                output.accept(data)
            } onError: { owner, err in
                print("onError", err)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(lotto: output)
    }
}

