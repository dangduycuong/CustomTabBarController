//
//  IPLookupAPIModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation

// MARK: - IPLookupAPIModel
struct IPLookupAPIModel: Codable {
    let ip, type, continentCode, continentName: String?
    let countryCode, countryName, isEu: String?
    let geonameID: Int?
    let city, region: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?
    
    enum CodingKeys: String, CodingKey {
        case ip, type
        case continentCode = "continent_code"
        case continentName = "continent_name"
        case countryCode = "country_code"
        case countryName = "country_name"
        case isEu = "is_eu"
        case geonameID = "geoname_id"
        case city, region, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}


