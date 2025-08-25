//
//  BoxViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxViewModel {
    
    struct Input {
        let searchButton: ControlEvent<Void>
        let query: ControlProperty<String?>
    }
    
    struct Output {
        let movies: BehaviorSubject<[BoxOffice]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let output = BehaviorSubject<[BoxOffice]>(value: [])
        
        input.searchButton
            .withLatestFrom(input.query.orEmpty) // 버튼 눌렸을 때 검색어 가져오기
            .distinctUntilChanged()
            .flatMapLatest { text in
                MovieObservable.getMoive(date: text)
            }
            .subscribe(with: self) { owner, movies in
                print("onNext", movies)
                output.onNext(movies)
            } onError: { owner, err in
                print("onError", err)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(movies: output)
    }
}
