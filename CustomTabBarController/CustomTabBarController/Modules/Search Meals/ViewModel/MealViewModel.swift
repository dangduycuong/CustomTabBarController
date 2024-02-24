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
    
}
