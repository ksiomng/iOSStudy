//
//  BoxViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class BoxViewModel {
    
    struct Input {
        let searchButton: ControlEvent<Void>
        let query: ControlProperty<String?>
    }
    
    struct Output {
        let movies: BehaviorRelay<[BoxOffice]>
        let toastMessage: BehaviorRelay<String?>
        let alertMessage: BehaviorRelay<String?>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let moviesRelay = BehaviorRelay<[BoxOffice]>(value: [])
        let toastMsg = BehaviorRelay<String?>(value: nil)
        let alertMsg = BehaviorRelay<String?>(value: nil)
        
        input.searchButton
            .withLatestFrom(input.query.orEmpty) // 버튼 눌렸을 때 검색어 가져오기
            .distinctUntilChanged()
            .flatMap { text in
                MovieObservable.getMoive(date: text)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let movies):
                    print("onNext movies", movies)
                    moviesRelay.accept(movies)
                    
                case .failure(let error):
                    print("❌ error:", error)
                    
                    if let afError = error as? AFError,
                       case let .sessionTaskFailed(underlyingError) = afError,
                       let urlError = underlyingError as? URLError,
                       urlError.code == .notConnectedToInternet {
                        alertMsg.accept("네트워크 연결이 원활하지 않습니다. 연결 상태를 확인해주세요.")
                    } else {
                        toastMsg.accept("박스오피스 API 호출 중 오류가 발생했습니다.")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(movies: moviesRelay, toastMessage: toastMsg, alertMessage: alertMsg)
    }
}
