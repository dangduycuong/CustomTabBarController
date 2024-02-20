//
//  Storyboard+Extension.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func storyBoard(_ storyboard: UIStoryboardType) -> UIStoryboard {
        return UIStoryboard(name: storyboard.identifier, bundle: nil)
    }
    
    func viewController<T: UIViewController>(of type: T.Type) -> T {
        guard let viewController =  instantiateViewController(withIdentifier: T.identifierView) as? T else {
            fatalError("Unabble to instantiate '\(T.identifierView)' ")
        }
        return viewController
    }
    
}

// MARK: Storyboard Type
enum UIStoryboardType {
    
    case main
    case werther
    case todo
    
    var identifier: String {
        switch self {
        case .main:
            return "Main"
        case .werther:
            return "Weather"
        case .todo:
            return "Todo"
        }
    }
}
