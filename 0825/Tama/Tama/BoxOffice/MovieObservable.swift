//
//  MovieObservable.swift
//  Tama
//
//  Created by Song Kim on 8/25/25.
//

import Foundation
import RxSwift
import Alamofire

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

final class MovieObservable {
    
    static func getMoive(date: String) -> Observable<Result<[BoxOffice], Error>> {
        let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.movieKey)&targetDt=\(date)")!
        
        return Observable<Result<[BoxOffice], Error>>.create { observer in
            AF.request(url).responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value.boxOfficeResult.dailyBoxOfficeList))
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
