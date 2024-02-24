//
//  MealAPI.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import Moya

public enum MealAPI {
    case allMealsByIngredient(params: Dictionary<String, Any>)
    case getListAllIngredients(params: Dictionary<String, Any>)
    case allMealsByArea(params: Dictionary<String, Any>)
    case getArea(params: Dictionary<String, Any>)
    case getMealsByCategory(params: Dictionary<String, Any>)
    case mealCategories
    case searchMealByName(params: Dictionary<String, Any>)
    case mealDetail(params: Dictionary<String, Any>)
}

extension MealAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: Configuration.shared.environment.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .allMealsByIngredient:
            return "filter.php"
        case .getListAllIngredients:
            return "list.php"
        case .allMealsByArea:
            return "/filter.php"
        case .getArea:
            return "/list.php"
        case .getMealsByCategory:
            return "filter.php"
        case .mealCategories:
            return "/categories.php"
        case .mealDetail:
            return "/lookup.php"
        case .searchMealByName:
            return "/search.php"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .allMealsByIngredient(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getListAllIngredients(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .allMealsByArea(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getArea(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getMealsByCategory(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .mealCategories:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .searchMealByName(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .mealDetail(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
            //        case .device(_):
            //            return [
            //                "appversion": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0")",
            //                "osversion": UIDevice.current.systemVersion,
            //                "manufacturer" : "Apple",
            //                "model": UIDevice.modelName
            //            ]
        default:
            return [:]
        }
        
    }
}
