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
    
    static func getLotto(query: String) -> Observable<Result<Lotto, Error>> {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        return Observable<Result<Lotto, Error>>.create { observer in
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value))
                    observer.onCompleted()
                case .failure(let err):
                    observer.onNext(.failure(err))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}


