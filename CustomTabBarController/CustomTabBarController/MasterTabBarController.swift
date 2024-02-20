//
//  MasterTabBarController.swift
//  CustomTabBarController
//
//  Created by Đặng Duy Cường on 1/7/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class MasterTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        //This method will be called when user changes tab.
//        print(item.accessibilityElementCount())
//    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 0) {
            item.title = ""
            // Code for item 1
            item.selectedImage = #imageLiteral(resourceName: "fourth-selected")
        } else if(item.tag == 1) {
            // Code for item 2
        }
    }
}
