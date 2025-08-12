//
//  SearchViewModel.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

class SearchViewModel {
    
    var inputSort = Observable(SortList.sim)
    var inputPage = Observable(1)
    var inputKeyword = Observable("")
    
    var outputShopList: Observable<[Shop]> = Observable([])
    var outputTotalCount = Observable(0)
    var outputError: Observable<String?> = Observable(nil)
    
    private let itemsPerPage = 30
    
    init() {
        inputKeyword.lazyBind { _ in
            self.fetchShopData()
        }
        inputPage.lazyBind { _ in
            self.fetchShopData()
        }
    }
    
    func totalPage() -> Int {
        guard outputTotalCount.value > 0 else { return 0 }
        return (outputTotalCount.value - 1) / itemsPerPage + 1
    }
    
    func fetchShopData() {
        let start = (inputPage.value - 1) * itemsPerPage + 1
        
        NetworkManager.shared.fetchShopDate(name: inputKeyword.value, sort: inputSort.value.rawValue, page: start, itemCount: itemsPerPage) { res in
            if res.total == 0 {
                self.outputError.value = "검색 결과가 없습니다."
            } else {
                if self.inputPage.value == 1 {
                    self.outputShopList.value = res.items
                } else {
                    self.outputShopList.value.append(contentsOf: res.items)
                }
            }
            self.outputTotalCount.value = res.total
        } fail: { err in
            if start > 1000 {
                self.outputError.value = "마지막 페이지입니다"
            } else {
                let errMsg = ErrorString.shared.result(errCode: err ?? 0)
                self.outputError.value = errMsg
            }
        }
    }
    
    func resetAndFetch() {
        inputPage.value = 1
        outputShopList.value.removeAll()
        fetchShopData()
    }
}
