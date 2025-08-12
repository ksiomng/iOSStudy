//
//  SearchViewModel.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

class SearchViewModel {
    
    var outputShopList: Observable<[Shop]> = Observable([])
    var inputPage = Observable(1)
    var inputTotalCount = Observable(0)
    var inputSort = Observable(SortList.sim)
    
    func totalPage() -> Int {
        let lastPage =  inputTotalCount.value / 30 == 0 ? (inputTotalCount.value / 30) : (inputTotalCount.value / 30) + 1
        return lastPage
    }
}
