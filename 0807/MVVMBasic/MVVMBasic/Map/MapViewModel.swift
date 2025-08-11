//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

class MapViewModel {
    private let restaurants = RestaurantList.restaurantArray
    
    var inputCategoryText = Field("")
    var outputAnnotation: Field<[Restaurant]> = Field([])
    
    init() {
        inputCategoryText.playAction { _ in
            self.filterAnnotation()
        }
    }
    
    func filterAnnotation() {
        let category = inputCategoryText.value
        if inputCategoryText.value == "" || inputCategoryText.value == "전체보기" {
            outputAnnotation.value = restaurants
        } else {
            let filterRestaurants = self.restaurants.filter { $0.category.contains(category) }
            outputAnnotation.value = filterRestaurants
        }
    }
}
