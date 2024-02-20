//
//  BaseViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 20/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addTitle(_ title: String) {
        view.layout(titleLabel)
            .topSafe().centerX()
        titleLabel.text = title
    }
    
    func addBackground() {
        view.backgroundColor = UIColor.white
    }

}
