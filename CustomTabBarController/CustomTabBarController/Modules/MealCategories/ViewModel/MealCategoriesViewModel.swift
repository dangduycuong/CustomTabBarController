//
//  MealCategoriesViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class MealCategoriesViewModel: BaseViewModel {
    var mealCategoriesDataSource = BehaviorRelay<[MealModel]>(value: [])
    var categoriesSource = [MealModel]()
    
    func filterMeal(searchText: String?) {
        let keyWord: String = (searchText ?? "").lowercased()
        var categories = [MealModel]()
        if keyWord == "" {
            categories = categoriesSource
        } else {
            categories = categoriesSource.filter { (meal: MealModel) in
                let strIngredient = meal.strCategory?.lowercased().unaccent()
                let strCategoryDescription = meal.strCategoryDescription?.lowercased().unaccent()
                
                if strIngredient?.range(of: keyWord) != nil {
                    return true
                }
                if strCategoryDescription?.range(of: keyWord) != nil {
                    return true
                }
                return false
            }
        }
        mealCategoriesDataSource.accept(categories)
    }
    
    func getMealCategories() {
        Utils.showLoadingIndicator()
        ApiClient.shared.callApi(MealAPI.mealCategories).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["categories"].array {
                    let categories = array.map { MealModel(json: $0) }
                    self.categoriesSource = categories
                    self.mealCategoriesDataSource.accept(categories)
                }
            }
        }.catch { [weak self] error in
            guard let `self` = self else { return }
            if let error = error as? ErrorClient {
                let errors = error.errors
                let phone = errors?["phone"].array?.first?.string ?? ""
                self.message.accept(phone)
            } else {
                self.message.accept(error.localizedDescription)
            }
        }.finally {
            Utils.hideLoadingIndicator()
        }
    }
}
