//
//  Utils.swift
//  CustomTabBarController
//
//  Created by cuongdd on 21/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class Utils: NSObject {
    
    class func topViewController(_ base: UIViewController? = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return topViewController(nav.topViewController)
            }
            if let tab = base as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return topViewController(selected)
                }
            }
            
            if let child = base?.children.last {
                return topViewController(child)
            }
            
            if let presented = base?.presentedViewController {
                return topViewController(presented)
            }
            return base
        }
    
    // MARK: - Hub
    
    class func showLoadingIndicator(_ message: String? = nil, _ isFullScreen: Bool? = false) {
        DispatchQueue.main.async {
            guard let topVC = topViewController() else { return }
            if isFullScreen == true {
                let vc = LoadingVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                topVC.present(vc, animated: true)
                return
            }
            let loadingView = CustomLoadingView()
            loadingView.backgroundColor = UIColor.black
            loadingView.layer.cornerRadius = 4
            topVC.view.layout(loadingView)
                .center().width(88).height(88)
        }
    }
    
    class func showLoadingWhiteScreen() {
        
    }
    
    class func hideLoadingIndicator() {
        DispatchQueue.main.async {
            if let topVC = topViewController() {
                if let _ = topVC as? LoadingVC {
                    topVC.dismiss(animated: true)
                    return
                }
                if let lastView = topVC.view.subviews.last as? CustomLoadingView {
                    lastView.removeFromSuperview()
                }
            }
        }
    }
    
    class func alignLeftAndRight(left: String, leftFont: UIFont, right: String, width: CGFloat, rightFont: UIFont, rightWith: CGFloat) -> String {
        var rightText = right
        if sizeOfString(string: rightText, constrainedToWidth: Double(width), font: rightFont).width > rightWith {
            rightText = replaceOfString(string: rightText, maxOf: Double(rightWith), font: rightFont)
        }
        let widthSpace = width - ((left as NSString).size(withAttributes: [.font : leftFont]).width + (rightText as NSString).size(withAttributes: [.font : rightFont]).width)
        
        let emptyStringWidth = (" " as NSString).size(withAttributes: [.font : rightFont]).width
        let numberOfSpacesToAdd = widthSpace/emptyStringWidth
        // create those spaces
        let spaces = Array(repeating: " ", count: numberOfSpacesToAdd < 0 ? 0 : Int(numberOfSpacesToAdd)).joined()
        let string = spaces + rightText
        // join these three things together
        print(string)
        return string
    }
    
    class func sizeOfString(string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let attString = NSAttributedString(string: string,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: Double.greatestFiniteMagnitude), nil)
    }
    
    class func replaceOfString(string: String, maxOf width: Double, font: UIFont) -> String {
        if (string as NSString).size(withAttributes: [.font : font]).width > CGFloat(width) {
            let newString = String(string.reversed())
            var newChars = ""
            for char in Array(newString) {
                if ((newChars + "\(char)...") as NSString).size(withAttributes: [.font : font]).width > CGFloat(width) {
                    return "..."+String(newChars.reversed())
                } else {
                    newChars.append(char)
                }
            }
        }
        
        return string
    }
    
    class func getCountryPhonceCode() -> String {
        return "1"
    }
    
    class func getDeviceID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "simulator"
    }
    
    class func getCurrentCountryCode() -> String {
        return Locale.current.regionCode ?? "test"
    }
    
    class func open(url: String, completed: (() -> Void)? = nil, error: (() -> Void)? = nil) {
        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    completed?()
                })
            }
        } else {
            error?()
        }
    }
}
