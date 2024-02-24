//
//  CustomLoadingView.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class CustomLoadingView: UIView {
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    // Override the initializer methods as needed
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom initialization code
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Custom initialization code
        setupView()
    }
    
    // Setup view properties or add subviews here
    private func setupView() {
        
        if spinner.isAnimating {
            return
        }
        self.layout(containerView)
            .center()
            .width(88)
            .height(88)
        containerView.layer.cornerRadius = 6
        containerView.backgroundColor = UIColor.black
        
        containerView.layout(spinner)
            .center()
        
        spinner.color = UIColor.white
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    // Override draw method for custom drawing (if needed)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Custom drawing code
    }
}

