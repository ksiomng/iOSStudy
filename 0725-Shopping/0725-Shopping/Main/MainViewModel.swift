//
//  MainViewModel.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

final class MainViewModel {
    
    struct Input {
        var searchWord: Observable<String?> = Observable("")
    }
    
    struct Output {
        var possibleSearchString = Observable("")
        var possibleSearch = Observable(false)
    }
    
    var input: Input
    var output: Output
    
    init() {
        input = Input()
        output = Output()
        
        input.searchWord.bind { _ in
            self.checkSearchWord()
        }
    }
    
    private func checkSearchWord() {
        guard let name = input.searchWord.value else {
            output.possibleSearchString.value = "검색 단어를 입력해주세요"
            output.possibleSearch.value = false
            return
        }
        if name.count < 2 {
            output.possibleSearchString.value = "2글자 이상 입력해주세요"
            output.possibleSearch.value = false
        } else {
            output.possibleSearchString.value = "검색 가능합니다"
            output.possibleSearch.value = true
        }
    }
}
