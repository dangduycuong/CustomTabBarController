//
//  MealViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class MealViewModel: BaseViewModel {
    var mealsDataSource = BehaviorRelay<[MealModel]>(value: [])
    var mealDetailDataSource = BehaviorRelay<MealModel>(value: MealModel())
    
    var ingredients = [String]()
    var measures = [String]()
    private var timer = Timer()
    
    var searchText: String = "" {
        didSet {
            if searchText != "" {
                enteringText(text: searchText)
            } else {
                timer.invalidate()
                mealsDataSource.accept([])
            }
        }
    }
    
    private func enteringText(text: String?) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(actionTimer(timer:)), userInfo: ["text": text], repeats: false)
    }
    
    @objc private func actionTimer(timer: Timer) {
        if let data = timer.userInfo as? [String: Any] {
            if let text = data["text"] as? String {
                searchMealByName(searchText: text)
            }
        }
    }
    
    func searchMealByName(searchText: String?) {
        Utils.showLoadingIndicator()
        var params = Dictionary<String, Any>()
        params["s"] = searchText ?? "chicken"
        ApiClient.shared.callApi(MealAPI.searchMealByName(params: params)).map { [weak self] response in
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
