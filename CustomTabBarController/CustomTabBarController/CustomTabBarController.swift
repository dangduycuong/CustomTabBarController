//
//  CustomTabBarController.swift
//  CustomTabBarController
//
//  Created by Đặng Duy Cường on 1/7/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    var homeViewController: HomeViewController!
    var secondViewController: SecondViewController!
    var actionViewController: ActionViewController!
    var thirdViewController: ThirdViewController!
    var fourthViewController: WeatherViewController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        let action = storyboard?.instantiateViewController(withIdentifier: "ActionViewController") as! ActionViewController
        let home = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController = home
        secondViewController = SecondViewController()
        actionViewController = action
        thirdViewController = ThirdViewController()
        
        let weather = UIStoryboard.storyBoard(.werther).viewController(of: WeatherViewController.self)
        fourthViewController = weather
        
        homeViewController.tabBarItem.image = UIImage(named: "home")
        homeViewController.tabBarItem.selectedImage =
        UIImage(named: "home-selected")
        secondViewController.tabBarItem.image = UIImage(named: "second")
        secondViewController.tabBarItem.selectedImage = UIImage(named: "second-selected")
        actionViewController.tabBarItem.image = UIImage(named: "action")
        actionViewController.tabBarItem.selectedImage = UIImage(named: "action-selected")
        thirdViewController.tabBarItem.image = UIImage(named: "third")
        thirdViewController.tabBarItem.selectedImage = UIImage(named: "third-selected")
        fourthViewController.tabBarItem.image = UIImage(named: "fourth")
        fourthViewController.tabBarItem.selectedImage = UIImage(named: "fourth-selected")
        viewControllers = [homeViewController, secondViewController, actionViewController, thirdViewController, fourthViewController]
        
        for i in 0..<tabBar.items!.count {
            tabBar.items![i].title = TabbarTitle.all[i].text
            tabBar.items![i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //        if viewController.isKind(of: ActionViewController.self) {
        //            let vc =  ActionViewController()
        //            vc.modalPresentationStyle = .overFullScreen
        //            self.present(vc, animated: true, completion: nil)
        //            return false
        //        }
        return true
    }
    
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //This method will be called when user changes tab.
        print(item.selectedImage as Any)
    }
    
    
}

enum TabbarTitle {
    case home
    case second
    case action
    case third
    case fourth
    
    static let all = [home, second, action, third, fourth]
    
    var text: String {
        get {
            switch self {
            case .home:
                return "home"
            case .second:
                return "second"
            case .action:
                return "action"
            case .third:
                return "third"
            case .fourth:
                return "fourth"
            }
        }
    }
}
