//
//  ForecastWeatherAPIModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecastWeatherAPIModel = try? newJSONDecoder().decode(ForecastWeatherAPIModel.self, from: jsonData)

import Foundation

// MARK: - PoemModel
struct ForecastWeatherAPIModel: Codable {
    var location: Location?
    var current: Current?
}

// MARK: - Current
struct Current: Codable {
    var lastUpdatedEpoch: Int?
    var lastUpdated: String?
    var tempC: Int?
    var tempF: Double?
    var isDay: Int?
    var condition: Condition?
    var windMph, windKph: Double?
    var windDegree: Int?
    var windDir: String?
    var pressureMB: Int?
    var pressureIn: Double?
    var precipMm, precipIn, humidity, cloud: Int?
    var feelslikeC, feelslikeF: Double?
    var visKM, visMiles, uv: Int?
    var gustMph, gustKph: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    var text, icon: String?
    var code: Int?
}

// MARK: - Location
struct Location: Codable {
    var name, region, country: String?
    var lat, lon: Double?
    var tzID: String?
    var localtimeEpoch: Int?
    var localtime: String?
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

