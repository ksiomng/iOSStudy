//
//  LottoModel.swift
//  0723
//
//  Created by Song Kim on 7/24/25.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo6: Int
    let drwtNo5: Int
    let drwtNo4: Int
    let drwtNo3: Int
    let drwtNo2: Int
    let drwtNo1: Int
    let bnusNo: Int
    let drwNo: Int // 회차정보
}
