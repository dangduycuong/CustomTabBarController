//
//  WeatherViewModel.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class WeatherViewModel {
    var forecastWeather: ForecastWeatherAPIModel?
    func fetchMealBycategories(completed: @escaping(() -> Void)) {
        let urlQueryItems = [
            URLQueryItem(name: "q", value: "auto:ip"),
        ]
        
        var urlComponents = URLComponents(string: "https://weatherapi-com.p.rapidapi.com/ip.json")
        urlComponents?.queryItems = urlQueryItems
        guard let url = urlComponents?.url else { return }
        var urlRequest = URLRequest(url: url)
        let headers = [
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
        ]
        urlRequest.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            print("Request: ", url)
            print("Params: ", url.query)
            print("Header: ", urlRequest.allHTTPHeaderFields)
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let data = data else { return }
            data.printFormatedJSON()
            do {
                //                let json = try JSONDecoder().decode(FullMealDetails.self, from: data)
                //                if let meals = json.meals {
                //                    self.meals = meals
                //                }
                completed()
            } catch let error {
                print("decode error: ", error)
            }
        })
        dataTask.resume()
        
    }
    
    
    func fetchForecastWeather(completed: @escaping(() -> Void)) {
        Utils.showLoadingIndicator(nil, true)
        let urlQueryItems = [
            URLQueryItem(name: "q", value: "hanoi"),
            URLQueryItem(name: "days", value: "3"),
        ]
        
        var urlComponents = URLComponents(string: "https://weatherapi-com.p.rapidapi.com/forecast.json")
        urlComponents?.queryItems = urlQueryItems
        guard let url = urlComponents?.url else { return }
        var urlRequest = URLRequest(url: url)
        let headers = [
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
        ]
        urlRequest.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            print("Request: ", url)
            print("Params: ", url.query as Any)
            print("Header: ", urlRequest.allHTTPHeaderFields as Any)
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let data = data else { return }
            data.printFormatedJSON()
            do {
                let json = try JSONDecoder().decode(ForecastWeatherAPIModel.self, from: data)
                self.forecastWeather = json
                Utils.hideLoadingIndicator()
                completed()
            } catch let error {
                print("decode error: ", error)
            }
        })
        dataTask.resume()
        
    }
    
    func downloadIcon(path: String, completed: @escaping((Data) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "weatherapi-com"
        urlComponents.path = path
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        let headers = [
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
        ]
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            print("Request: ", url)
            print("Params: ", url.query as Any)
            print("Header: ", request.allHTTPHeaderFields as Any)
            
            if let data = data {
                Utils.hideLoadingIndicator()
                completed(data)
            }
            if let error = error {
                print("---- xinh nhat tren doi aye", error)
            }
            if let response = response as? HTTPURLResponse {
                print("----", response.statusCode)
            }
        }
        dataTask.resume()
    }
}
