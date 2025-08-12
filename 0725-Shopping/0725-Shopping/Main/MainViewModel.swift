//
//  MainViewModel.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

class MainViewModel {
    var inputSearchWord: Observable<String?> = Observable("")
    
    var outputPossibleSearchString = Observable("")
    var outputPossibleSearch = Observable(false)
    
    init() {
        inputSearchWord.bind { _ in
            self.checkSearchWord()
        }
    }
    
    func checkSearchWord() {
        guard let name = inputSearchWord.value else {
            outputPossibleSearchString.value = "검색 단어를 입력해주세요"
            outputPossibleSearch.value = false
            return
        }
        if name.count < 2 {
            outputPossibleSearchString.value = "2글자 이상 입력해주세요"
            outputPossibleSearch.value = false
        } else {
            outputPossibleSearchString.value = "검색 가능합니다"
            outputPossibleSearch.value = true
        }
    }
}
