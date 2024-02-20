//
//  BaseViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 20/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var loadingVC = LoadingVC()
    
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
    
    func startAnimating() {
        loadingVC.modalPresentationStyle = .overFullScreen
        loadingVC.modalTransitionStyle = .crossDissolve
        present(loadingVC, animated: true)
    }
    
    func stopAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingVC.dismiss(animated: true)
        }
    }
}

class LoadingVC: UIViewController {
    lazy var loadingView: UIView = {
        let view = UIView()
        return view
    }()
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareForViewController()
    }
    
    private func prepareForViewController() {
        startAnimating()
    }
    
    func startAnimating() {
        if spinner.isAnimating {
            return
        }
        view.layout(loadingView)
            .top().left().bottom().right()
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.layout(spinner)
            .center()
        spinner.color = UIColor.white
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    func stopAnimating() {
        //        spinner.stopAnimating()
        //        spinner.removeFromSuperview()
    }
    
    deinit {
        print("---- deinit LoadingVC")
    }
}
