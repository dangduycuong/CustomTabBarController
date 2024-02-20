//
//  WeatherViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var lastUpdatedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var viewModel = WeatherViewModel()
    
    override func loadView() {
        super.loadView()
        
        prepareForViewController()
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
            if let icon = self.viewModel.forecastWeather?.current?.condition?.icon {
                self.viewModel.downloadIcon(path: icon) { data in
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
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
    
    private func prepareForViewController() {
        addBackground()
        addTitle("Thời Tiết")
        
        view.layout(locationLabel)
            .below(titleLabel, 32)
            .left(16)
            .right(16)
        
        view.layout(lastUpdatedLabel)
            .below(locationLabel, 16)
            .left(16)
            .right(16)
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
