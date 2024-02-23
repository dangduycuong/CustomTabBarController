//
//  BaseViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 20/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    var loadingVC = LoadingVC()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
            .topSafe(16).centerX()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = title
    }
    
    func addBackground() {
        view.backgroundColor = UIColor.white
    }
    
    func addBackButton() {
        let image = R.image.previous()
        backImageView.image = image
        view.layout(backImageView)
            .left(16).centerY(titleLabel).width(24).height(24)
        
        view.layout(backButton)
            .center(backImageView).width(40).height(40)
    }
    
    @objc func addBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
    
    func showMessageAlert(message: String, close: @escaping () -> Void) {
        let vc = ShowAlertViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.messageAlert = message
        vc.closeAlert = close
        
        present(vc, animated: true)
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
