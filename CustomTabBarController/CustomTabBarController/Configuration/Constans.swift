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
            return "https://dev-api.driverdoc.io"
        case .master:
            return "https://qa-api.driverdoc.io"
        case .production:
            return "https://api.driverdoc.io"
        }
    }
    
    var baseUrl: String {
        return "\(domain)/api/json/v1/1"
    }
    
    var googleMapUrl: String {
        return "https://maps.googleapis.com/maps/api/"
    }
    
    var googleAPIKey: String {
        return "AIzaSyCSzKRjZHWcpNQAM_pb8ZIaI4s1Sl19iao"
    }
    
    var pendoKey: String {
        switch self {
        case .debug:
            return "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiJiODFlZGMyN2ZlNWQ4NzZiMTQ2ZjgxNmI2MTQzZDkxNWExMzljMDUxNGU2ZWJmNTdjMTY0MjViZTZmOTE1MDJmNDRlNGZmOWM4MWI3NGFjMWEyNDNhY2NkYTU4NDdiNWVlNjFjODJiNjcwZmU1ZTU2MWJkMGU4ZDA5ZjYxYWQzM2U4NzkzZDM1NGFlYTQ2OWM0NmFlOGJkYzFmMTZiMDIwODVmZmEyN2FkZGMxYmI0ZDgxZmI3Nzc2OWU4MDZiOGIxYjg0ZGQyMzg5MWFhNTA0YzA1NTgxNzRmOGZmOWY0OC45NTUyZDgyNmU1MDI2MTZiZWJjMmRlNjUwMTE3MWUyZC5iMTdlOWM4ZDgwODRlN2U3OTI2MDQ3MTQ1ZmJlYWY3NTg1NzI2ODk5NTQ0ODk2YzIzNWZhM2YwMTExYTBiYTY5In0.M4JSX82WYX8auARLVRMFshyY38lOT2k1PshOYTvU8ysUNq6392_oPYee5snN84Am8mK72LrlM3aHopVRQbYFZk6bOpx_lxbnS-ePv6ovGc_X_yIOXt3dF-ZBVWJmua8ByAoO-dYTByZ4vmy1MOozAK4upkgmh5Czqf6-n_BQZwI"
        case .uat:
            return "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiJiODFlZGMyN2ZlNWQ4NzZiMTQ2ZjgxNmI2MTQzZDkxNWExMzljMDUxNGU2ZWJmNTdjMTY0MjViZTZmOTE1MDJmNDRlNGZmOWM4MWI3NGFjMWEyNDNhY2NkYTU4NDdiNWVlNjFjODJiNjcwZmU1ZTU2MWJkMGU4ZDA5ZjYxYWQzM2U4NzkzZDM1NGFlYTQ2OWM0NmFlOGJkYzFmMTZiMDIwODVmZmEyN2FkZGMxYmI0ZDgxZmI3Nzc2OWU4MDZiOGIxYjg0ZGQyMzg5MWFhNTA0YzA1NTgxNzRmOGZmOWY0OC45NTUyZDgyNmU1MDI2MTZiZWJjMmRlNjUwMTE3MWUyZC5iMTdlOWM4ZDgwODRlN2U3OTI2MDQ3MTQ1ZmJlYWY3NTg1NzI2ODk5NTQ0ODk2YzIzNWZhM2YwMTExYTBiYTY5In0.M4JSX82WYX8auARLVRMFshyY38lOT2k1PshOYTvU8ysUNq6392_oPYee5snN84Am8mK72LrlM3aHopVRQbYFZk6bOpx_lxbnS-ePv6ovGc_X_yIOXt3dF-ZBVWJmua8ByAoO-dYTByZ4vmy1MOozAK4upkgmh5Czqf6-n_BQZwI"
        case .master:
            return "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiJiODFlZGMyN2ZlNWQ4NzZiMTQ2ZjgxNmI2MTQzZDkxNWExMzljMDUxNGU2ZWJmNTdjMTY0MjViZTZmOTE1MDJmNDRlNGZmOWM4MWI3NGFjMWEyNDNhY2NkYTU4NDdiNWVlNjFjODJiNjcwZmU1ZTU2MWJkMGU4ZDA5ZjYxYWQzM2U4NzkzZDM1NGFlYTQ2OWM0NmFlOGJkYzFmMTZiMDIwODVmZmEyN2FkZGMxYmI0ZDgxZmI3Nzc2OWU4MDZiOGIxYjg0ZGQyMzg5MWFhNTA0YzA1NTgxNzRmOGZmOWY0OC45NTUyZDgyNmU1MDI2MTZiZWJjMmRlNjUwMTE3MWUyZC5iMTdlOWM4ZDgwODRlN2U3OTI2MDQ3MTQ1ZmJlYWY3NTg1NzI2ODk5NTQ0ODk2YzIzNWZhM2YwMTExYTBiYTY5In0.M4JSX82WYX8auARLVRMFshyY38lOT2k1PshOYTvU8ysUNq6392_oPYee5snN84Am8mK72LrlM3aHopVRQbYFZk6bOpx_lxbnS-ePv6ovGc_X_yIOXt3dF-ZBVWJmua8ByAoO-dYTByZ4vmy1MOozAK4upkgmh5Czqf6-n_BQZwI"
        case .production:
            return "eyJhbGciOiJSUzI1NiIsImtpZCI6IiIsInR5cCI6IkpXVCJ9.eyJkYXRhY2VudGVyIjoidXMiLCJrZXkiOiJiODFlZGMyN2ZlNWQ4NzZiMTQ2ZjgxNmI2MTQzZDkxNWExMzljMDUxNGU2ZWJmNTdjMTY0MjViZTZmOTE1MDJmNDRlNGZmOWM4MWI3NGFjMWEyNDNhY2NkYTU4NDdiNWVlNjFjODJiNjcwZmU1ZTU2MWJkMGU4ZDA5ZjYxYWQzM2U4NzkzZDM1NGFlYTQ2OWM0NmFlOGJkYzFmMTZiMDIwODVmZmEyN2FkZGMxYmI0ZDgxZmI3Nzc2OWU4MDZiOGIxYjg0ZGQyMzg5MWFhNTA0YzA1NTgxNzRmOGZmOWY0OC45NTUyZDgyNmU1MDI2MTZiZWJjMmRlNjUwMTE3MWUyZC5iMTdlOWM4ZDgwODRlN2U3OTI2MDQ3MTQ1ZmJlYWY3NTg1NzI2ODk5NTQ0ODk2YzIzNWZhM2YwMTExYTBiYTY5In0.M4JSX82WYX8auARLVRMFshyY38lOT2k1PshOYTvU8ysUNq6392_oPYee5snN84Am8mK72LrlM3aHopVRQbYFZk6bOpx_lxbnS-ePv6ovGc_X_yIOXt3dF-ZBVWJmua8ByAoO-dYTByZ4vmy1MOozAK4upkgmh5Czqf6-n_BQZwI"
        }
    }
    
    var cameraGeniusKey: String {
        switch self {
        case .debug:
            return "533c5007505704060055045439585a4d00115b125144565601184003444c5140126b55550c04020f57070400"
        case .uat:
            return "533c5007505704060055045439585a4d00115b125144565601185907444c55420344143d09020206510508015b54"
        case .master:
            return "533c5007505704060055045439585a4d00115b125144565601185907444c55420344143d09020206510508015b54"
        case .production:
            return "533c5007505704060055045439585a4d00115b125144565601184414585c5140126b55550c04020f57040701"
        }
    }
    
    var awsconfiguration: String {
        switch self {
        case .debug:
            return "awsconfiguration-dev"
        case .uat:
            return "awsconfiguration-dev"
        case .master:
            return "awsconfiguration-master"
        case .production:
            return "awsconfiguration-production"
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
            return "2edd34b4-8d05-4d6b-b16f-97c4b7186e91"
        case .debug:
            return "2edd34b4-8d05-4d6b-b16f-97c4b7186e91"
        case .master:
            return "4bbde848-712b-43a1-a3b5-58a6b5298951"
        case .production:
            return ""
        }
    }
    
    var GAITrackingId: String {
        switch self {
        case .uat:
            return "259911952"
        case .debug:
            return "2274517811"
        case .master:
            return "2274497961"
        case .production:
            return "2260908408"
        }
    }
}
