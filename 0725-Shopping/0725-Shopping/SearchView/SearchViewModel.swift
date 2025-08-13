//
//  SearchViewModel.swift
//  0725-Shopping
//
//  Created by Song Kim on 8/12/25.
//

import Foundation

final class SearchViewModel {
    
    struct Input {
        var sort = Observable(SortList.sim)
        var page = Observable(1)
        var keyword = Observable("")
    }
    
    struct Output {
        var shopList: Observable<[Shop]> = Observable([])
        var totalCount = Observable(0)
        var error: Observable<String?> = Observable(nil)
    }
    
    var input: Input
    var output: Output
    
    private let itemsPerPage = 30
    
    init() {
        input = Input()
        output = Output()
        
        input.keyword.lazyBind { _ in
            self.fetchShopData()
        }
        input.page.lazyBind { _ in
            self.fetchShopData()
        }
    }
    
    func totalPage() -> Int {
        guard output.totalCount.value > 0 else { return 0 }
        return (output.totalCount.value - 1) / itemsPerPage + 1
    }
    
    private func fetchShopData() {
        let start = (input.page.value - 1) * itemsPerPage + 1
        
        NetworkManager.shared.callRequest(api: .searchShop(name: input.keyword.value, itemCount: itemsPerPage, page: start, sort: input.sort.value.rawValue), type: Shops.self) { res in
            if res.total == 0 {
                self.output.error.value = "검색 결과가 없습니다."
            } else {
                if self.input.page.value == 1 {
                    self.output.shopList.value = res.items
                } else {
                    self.output.shopList.value.append(contentsOf: res.items)
                }
            }
            self.output.totalCount.value = res.total
        } fail: { err in
            if start > 1000 {
                self.output.error.value = "마지막 페이지입니다"
            } else {
                let errMsg = ErrorString.shared.result(errCode: err ?? 0)
                self.output.error.value = errMsg
            }
        }
    }
    
    func resetAndFetch() {
        input.page.value = 1
        output.shopList.value.removeAll()
        fetchShopData()
    }
}
