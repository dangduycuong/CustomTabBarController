//
//  WeatherViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    var viewModel = WeatherViewModel()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "uuu"
//        viewModel.fetchMealBycategories { [weak self] in
//            guard let `self` = self else { return }
//            
//            
//        }
        
        viewModel.fetchForecastWeather { [weak self] in
            guard let `self` = self else { return }
            self.updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if let country = self.viewModel.forecastWeather?.location?.country,
               let name = self.viewModel.forecastWeather?.location?.name {
                self.locationLabel.text = country + " - " + name
            }
            if let lastUpdated = self.viewModel.forecastWeather?.current?.lastUpdated {
                self.lastUpdatedLabel.text = lastUpdated
            }
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
