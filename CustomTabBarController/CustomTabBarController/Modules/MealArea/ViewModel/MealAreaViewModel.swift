//
//  MealAreaViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class MealAreaViewModel: BaseViewModel {
    var mealsDataSource = BehaviorRelay<[MealModel]>(value: [])
    private var areasSource = [MealModel]()
    
    func filterMeal(searchText: String?) {
        let keyWord: String = (searchText ?? "").lowercased()
        var areas = [MealModel]()
        if keyWord == "" {
            areas = areasSource
        } else {
            areas = areasSource.filter { (meal: MealModel) in
                if let strIngredient = meal.strArea?.lowercased().unaccent() {
                    if strIngredient.range(of: keyWord) != nil {
                        return true
                    }
                }
                return false
            }
        }
        mealsDataSource.accept(areas)
    }
    
    func getMealsArea() {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["a"] = "list"
        ApiClient.shared.callApi(MealAPI.getArea(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let meals = array.map { MealModel(json: $0) }
                    self.areasSource = meals
                    self.mealsDataSource.accept(meals)
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
