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
    var mealViewController: MealViewController!
    var mealCategories: MealCategoriesViewController!
    var mealAreaViewController: MealAreaViewController!
    var mealIngredientViewController: MealIngredientViewController!
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        homeViewController = HomeTodosViewController()
        mealViewController = MealViewController()
        mealCategories = MealCategoriesViewController()
        mealAreaViewController = MealAreaViewController()
        mealIngredientViewController = MealIngredientViewController()
        
        
        homeViewController.tabBarItem.image = UIImage(named: "home")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "home-selected")
        mealViewController.tabBarItem.image = UIImage(named: "second")
        mealViewController.tabBarItem.selectedImage = UIImage(named: "second-selected")
        mealCategories.tabBarItem.image = UIImage(named: "action")
        mealCategories.tabBarItem.selectedImage = UIImage(named: "action-selected")
        mealAreaViewController.tabBarItem.image = UIImage(named: "third")
        mealAreaViewController.tabBarItem.selectedImage = UIImage(named: "third-selected")
        mealIngredientViewController.tabBarItem.image = UIImage(named: "fourth")
        mealIngredientViewController.tabBarItem.selectedImage = UIImage(named: "fourth-selected")
        
        viewControllers = [homeViewController, mealViewController, mealCategories, mealAreaViewController, mealIngredientViewController]
        
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


