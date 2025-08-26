//
//  LottoViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class LottoViewModel {
    
    struct Input {
        let searchButton: ControlEvent<Void>
        let query: ControlProperty<String?>
    }
    
    struct Output {
        let lotto: BehaviorRelay<[Lotto]>
        let toastMessage: BehaviorRelay<String?>
        let alertMessage: BehaviorRelay<String?>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let lottoRelay = BehaviorRelay<[Lotto]>(value: [])
        let toastMsg = BehaviorRelay<String?>(value: nil)
        let alertMsg = BehaviorRelay<String?>(value: nil)
        
        input.searchButton
            .withLatestFrom(input.query.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                LottoObservable.getLotto(query: text)
            }
            .bind(with: self) { owner, response in
                print("onNext", response)
                var data = lottoRelay.value
                
                switch response {
                case .success(let lotto):
                    data.insert(lotto, at: 0)
                    lottoRelay.accept(data)
                    
                case .failure(let error):
                    print("❌ error:", error)
                    
                    // Alamofire Error -> AFError -> URLError
                    if let afError = error as? AFError,
                       case let .sessionTaskFailed(underlyingError) = afError,
                       let urlError = underlyingError as? URLError,
                       urlError.code == .notConnectedToInternet {
                        alertMsg.accept("네트워크 연결이 원활하지 않습니다. 연결 상태를 확인해주세요.")
                    } else {
                        toastMsg.accept("API 오류 발생")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(lotto: lottoRelay, toastMessage: toastMsg, alertMessage: alertMsg)
    }
}

