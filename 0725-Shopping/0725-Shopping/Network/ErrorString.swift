//
//  ErrorString.swift
//  0725-Shopping
//
//  Created by Song Kim on 7/29/25.
//

import Foundation

class ErrorString {
    static let shared = ErrorString()
    
    private init() { }
    
    func result(errCode: Int) -> String {
        switch errCode {
        case 400:
            return "1. 필수 요청 변수가 없거나 요청 변수 이름이 잘못된 경우\n2. 요청 변수의 값을 URL 인코딩으로 변환하지 않고 전송한 경우"
        case 401:
            return "1. 클라이언트 아이디와 클라이언트 시크릿이 없거나 잘못된 값인 경우\n2. API 권한이 설정되지 않은 경우\n3. 접근 토큰 파라미터(access_token)가 없거나 잘못된 값(만료된 접근 토큰)을 설정한 경우"
        case 403:
            return "1. HTTPS가 아닌 HTTP로 호출한 경우\n2. 요청 변수의 값을 URL 인코딩으로 변환하지 않고 전송한 경우"
        case 404:
            return "API 요청 URL이 잘못된 경우"
        case 405:
            return "HTTP 메서드를 잘못 호출한 경우."
        case 429:
            return "1. 오픈 API를 호출할 때 하루 허용량을 초과한 경우\n2. 검색 API를 호출할 때 초당 호출량을 초과한 경우"
        case 500:
            return "API 호출은 정상적으로 했지만, API 서버 유지 보수나 시스템 오류로 인한 오류가 발생한 경우"
        default:
            return "네트워크 연결 되어있지 않은경우"
        }
    }
}
