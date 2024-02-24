//
//  MealModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

struct MealModel {
    var idMeal: String?
    var strMeal: String?
    var strCategory: String?
    var strArea: String?
    
    var strInstructions: String?
    var strMealThumb: String?
    var idCategory: String?
    var strCategoryThumb: String?
    
    var strCategoryDescription: String?
    var idIngredient: String?
    var strIngredient: String?
    var strDescription: String?
    
    init(json: JSON? = nil) {
        guard let json = json else { return }
        
        idMeal = json["idMeal"].string
        strMeal = json["strMeal"].string
        strCategory = json["strCategory"].string
        strArea = json["strArea"].string
        
        strInstructions = json["strInstructions"].string
        strMealThumb = json["strMealThumb"].string
        idCategory = json["idCategory"].string
        strCategoryThumb = json["strCategoryThumb"].string
        
        strCategoryDescription = json["strCategoryDescription"].string
        idIngredient = json["idIngredient"].string
        strIngredient = json["strIngredient"].string
        strDescription = json["strDescription"].string
    }
}
