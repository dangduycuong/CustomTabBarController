//
//  MealDetailViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 24/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class MealDetailViewModel: BaseViewModel {
    var mealDetailDataSource = BehaviorRelay<MealModel>(value: MealModel())
    
    var ingredients = [String]()
    var measures = [String]()
    
    func getMealDetail(id: String?) {
        Utils.showLoadingIndicator()
        var mealModel = MealModel()
        var params = Dictionary<String, Any>()
        params["i"] = id
        ApiClient.shared.callApi(MealAPI.mealDetail(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    if let firstItem = array.first {
                        for i in 0...30 {
                            if let ingredient = firstItem["strIngredient\(i)"].string, ingredient != "" {
                                self.ingredients.append(ingredient)
                            }
                            if let measure = firstItem["strMeasure\(i)"].string, measure != " ", measure != "" {
                                self.measures.append(measure)
                            }
                        }
                    }
                    
                    let meals = array.map { MealModel(json: $0) }
                    if let meal = meals.first {
                        mealModel = meal
                    }
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
            self.mealDetailDataSource.accept(mealModel)
        }
    }
}
