//
//  WeatherViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class MealIngredientViewModel: BaseViewModel {
    var ingredientsDataSource = BehaviorRelay<[MealModel]>(value: [])
    
    func getListAllIngredients() {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["i"] = "list"
        ApiClient.shared.callApi(MealAPI.getListAllIngredients(params: params)).map { [weak self] response in
            guard let `self` = self else { return }
            if let data = response.data {
                if let array = data["meals"].array {
                    let ingredients = array.map { MealModel(json: $0) }
                    self.ingredientsDataSource.accept(ingredients)
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
