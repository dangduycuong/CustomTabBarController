//
//  Constans.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

struct Constrains {
    static var heightButton: CGFloat {
        return 48
    }
    
    static var leftspace: CGFloat {
        return 16
    }
    
    static var corradius: CGFloat {
        return 16
    }
}
struct Constants {
    
    // MARK: - COLOR
    struct Color {
        static let DEFAULT_GREEN = "#38BA42"
        static let DEFAULT_GRAY = "#9B9B9B"
    }
    
    // MARK: - Application
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let appWindow = Constants.appDelegate?.window
    struct App {
        
        // MARK: Main
        static let isHTTPS = false
        static let navigationBarColor = "0070BE"
        
        // MARK: DateTime
        
        static let kOnlyDateFormat = "mm/dd/yyyy"
        static let kOnlyTimeFormat = "hh:MM a"
    }
    
    struct Segue {
        static let kLEFTMENU_TO_HOME = "LEFTMENU_TO_HOME"
        static let kSEGUE_LOGIN_TO_MAIN = "SEGUE_LOGIN_TO_MAIN"
    }
    
    struct GeneralNumberFormat {
        // MARK: General number formatter keys
        
        /// General ordinal key
        static let NumberFormatterOrdinalKey = "ordinal"
        /// General spell out key
        static let NumberFormatterSpellOutKey = "spellout"
        /// General distance key
        static let NumberFormatterDistanceKey = "distance"
        
        // MARK: Mass number formatter keys
        
        /// Mass generic key
        static let MassFormatterGenericKey = "mass_generic"
        /// Mass person key
        static let MassFormatterPersonKey = "mass_person"
    }
}

extension Notification{
    static var updateCoin:Notification = Notification(name: Notification.Name(rawValue: "updateCoin"))
    static var feedback:Notification = Notification(name: Notification.Name(rawValue: "feedback"))
    
}

extension Notification.Name{
    static var updateCoin = Notification.Name(rawValue: "updateCoin")
    static var feedback = Notification.Name(rawValue: "feedback")
    
}

struct Configuration {
    static let shared = Configuration()
    var currentLocation: Bool = true
    var environment: Environment {
#if DEBUG
        return .debug
#elseif UAT
        return .uat
#elseif MASTER
        return .master
#else
        return .production
#endif
    }
    
}

enum Environment {
    case debug
    case uat
    case master
    case production
    
    var domain: String {
        switch self {
        case .debug:
            return "https://www.themealdb.com"
        case .uat:
            return "https://www.themealdb.com"
        case .master:
            return "https://www.themealdb.com"
        case .production:
            return "https://www.themealdb.com"
        }
    }
    
    var baseUrl: String {
        return "\(domain)/api/json/v1/1"
    }
    
    var googleMapUrl: String {
        return "https://maps.googleapis.com/maps/api/"
    }
    
    var googleAPIKey: String {
        return ""
    }
    
    var pendoKey: String {
        switch self {
        case .debug:
            return ""
        case .uat:
            return ""
        case .master:
            return ""
        case .production:
            return ""
        }
    }
    
    var cameraGeniusKey: String {
        switch self {
        case .debug:
            return ""
        case .uat:
            return ""
        case .master:
            return ""
        case .production:
            return ""
        }
    }
    
    var firebasePath: String? {
        switch self {
        case .debug:
            return Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")
        case .uat:
            return Bundle.main.path(forResource: "GoogleService-Info-UAT", ofType: "plist")
        case .master:
            return Bundle.main.path(forResource: "GoogleService-Info-MASTER", ofType: "plist")
        case .production:
            return Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        }
    }
    
    var appcenterKey: String {
        switch self {
        case .uat:
            return ""
        case .debug:
            return ""
        case .master:
            return ""
        case .production:
            return ""
        }
    }
    
    var GAITrackingId: String {
        switch self {
        case .uat:
            return ""
        case .debug:
            return ""
        case .master:
            return ""
        case .production:
            return ""
        }
    }
}
