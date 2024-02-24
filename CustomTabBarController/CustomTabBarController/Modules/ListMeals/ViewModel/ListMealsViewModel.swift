//
//  ListMealsViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 24/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class ListMealsViewModel: BaseViewModel {
    var mealsDataSource = BehaviorRelay<[MealModel]>(value: [])
    
    func getMealsByCategory(mealCategory: String?) {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["c"] = mealCategory
        ApiClient.shared.callApi(MealAPI.getMealsByCategory(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let meals = array.map { MealModel(json: $0) }
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
    
    func allMealsByArea(area: String?) {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["a"] = area
        ApiClient.shared.callApi(MealAPI.allMealsByArea(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let meals = array.map { MealModel(json: $0) }
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
    
    func allMealsByIngredient(ingredient: String?) {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["i"] = ingredient
        ApiClient.shared.callApi(MealAPI.allMealsByIngredient(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let meals = array.map { MealModel(json: $0) }
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
