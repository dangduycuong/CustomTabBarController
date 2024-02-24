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
    var mealsSource = [MealModel]()
    
    func filterMeal(searchText: String?) {
        let keyWord: String = (searchText ?? "").lowercased()
        var meals = [MealModel]()
        if keyWord == "" {
            meals = mealsSource
        } else {
            meals = mealsSource.filter { (meal: MealModel) in
                let strMeal = meal.strMeal?.lowercased().unaccent()
                let strInstructions = meal.strInstructions?.lowercased().unaccent()
                
                if strMeal?.range(of: keyWord) != nil {
                    return true
                }
                
                if strInstructions?.range(of: keyWord) != nil {
                    return true
                }
                
                return false
            }
        }
        mealsDataSource.accept(meals)
    }
    
    func getMealsByCategory(mealCategory: String?) {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["c"] = mealCategory
        ApiClient.shared.callApi(MealAPI.getMealsByCategory(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let meals = array.map { MealModel(json: $0) }
                    self.mealsSource = meals
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
                    self.mealsSource = meals
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
                    self.mealsSource = meals
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
