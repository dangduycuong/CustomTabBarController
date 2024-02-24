//
//  TabbarTitle.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

enum TabbarTitle {
    case home
    case meals
    case mealCategories
    case area
    case ingredient
    
    static let all = [home, meals, mealCategories, area, ingredient]
    
    var text: String {
        get {
            switch self {
            case .home:
                return "Home"
            case .meals:
                return "Meals"
            case .mealCategories:
                return "Categories"
            case .area:
                return "Area"
            case .ingredient:
                return "Ingredients"
            }
        }
    }
}
