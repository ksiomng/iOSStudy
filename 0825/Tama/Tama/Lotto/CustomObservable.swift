//
//  CustomObservable.swift
//  Tama
//
//  Created by Song Kim on 8/25/25.
//

import Foundation
import RxSwift
import Alamofire

enum LottoError: Error {
    case failAPI
}

final class LottoObservable {
    
    static func getLotto(query: String) -> Observable<Lotto> {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        return Observable<Lotto>.create { observer in
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value.drwNoDate)
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(LottoError.failAPI)
                }
            }
            return Disposables.create()
        }
    }
}


