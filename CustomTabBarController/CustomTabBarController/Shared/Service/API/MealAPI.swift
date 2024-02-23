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
    case searchMealByName(params: Dictionary<String, Any>)
    case mealDetail(params: Dictionary<String, Any>)
    case register(params: Dictionary<String, Any>)
    case verifyOtp(params: Dictionary<String, Any>)
    case logIn(params: Dictionary<String, Any>)
    case getProfile
    case updateProfile(params: Dictionary<String, Any>)
    case getListVehicleType(params: Dictionary<String, Any>)
    case resetPassword(params: Dictionary<String, Any>)
    case logOut
    case changePassword(params: Dictionary<String, Any>)
    case getTrip
    case getProvince
    case getDistrict(params: Dictionary<String, Any>)
    case getStartPoint(tripId: Int)
    case setStartPoint(tripId: Int, params: Dictionary<String, Any>)
    case getEndPoint(tripId: Int)
    case setEndPoint(tripId: Int, params: Dictionary<String, Any>)
    case getBookingHistory
    case carDecal
    case updateSetting(params: Dictionary<String, Any>)
    case getBooking(params: Dictionary<String, Any>)
}

extension MealAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: Configuration.shared.environment.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .mealDetail:
            return "/lookup.php"
        case .searchMealByName:
            return "/search.php"
        case .register:
            return "/driver/register"
        case .verifyOtp:
            return "/driver/verify-otp"
        case .logIn:
            return "/driver/login"
        case .getProfile:
            return "/driver/profile"
        case .updateProfile:
            return "/driver/profile"
        case .getListVehicleType:
            return "/driver/vehicle-type"
        case .resetPassword:
            return "/driver/reset-password"
        case .logOut:
            return "/driver/logout"
        case .changePassword:
            return "/driver/change-password"
        case .getTrip:
            return "/driver/trip"
        case .getProvince:
            return "/driver/system/province"
        case .getDistrict:
            return "/driver/system/district"
        case .getStartPoint(let tripId):
            return "/driver/trip/\(tripId)/start"
        case .setStartPoint(let tripId, _):
            return "/driver/trip/\(tripId)/start"
        case .getEndPoint(let tripId):
            return "/driver/trip/\(tripId)/end"
        case .setEndPoint(let tripId, _):
            return "/driver/trip/\(tripId)/end"
        case .getBookingHistory:
            return "/driver/booking/history-bid"
        case .carDecal:
            return "/driver/system/car-decal"
        case .updateSetting:
            return "/driver/update-setting"
        case .getBooking:
            return "driver/booking"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProfile, .getListVehicleType, .getTrip, .getProvince, .getDistrict, .getStartPoint, .getBookingHistory, .getEndPoint, .carDecal, .getBooking, .searchMealByName, .mealDetail:
            return .get
        case .updateProfile, .setStartPoint, .setEndPoint, .updateSetting:
            return .put
        default:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .searchMealByName(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .mealDetail(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .register(let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .verifyOtp(let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .logIn(let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .getProfile:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .updateProfile(let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .getListVehicleType(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .resetPassword(let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .logOut:
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .changePassword(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getTrip:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .getProvince:
            return .requestParameters(parameters: ["per_page": 200], encoding: URLEncoding.default)
        case .getDistrict(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getStartPoint:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .setStartPoint(_, let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .getEndPoint:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .setEndPoint(_, let params):
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .getBookingHistory:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .carDecal:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .updateSetting(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getBooking(let params):
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
