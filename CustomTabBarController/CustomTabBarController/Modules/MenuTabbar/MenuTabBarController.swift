//
//  MenuTabBarController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController, UITabBarControllerDelegate {
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    var homeViewController: HomeTodosViewController!
    var secondViewController: MealViewController!
    var actionViewController: ActionViewController!
    var thirdViewController: ThirdViewController!
    var fourthViewController: WeatherViewController!
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        let action = storyboard?.instantiateViewController(withIdentifier: "ActionViewController") as! ActionViewController
        
        let home = HomeTodosViewController()
        homeViewController = home
        secondViewController = MealViewController()
        actionViewController = action
        thirdViewController = ThirdViewController()
        
        let weather = WeatherViewController()
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
                return "Home"
            case .second:
                return "Meals"
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
