//
//  ShowAlertViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 21/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class ShowAlertViewController: UIViewController {
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var messageAlert: String = ""
    var titleClose: String = ""
    var closeAlert: (() -> Void)?
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
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
    private func prepareForViewController() {
        view.layout(contentView)
            .center()
            .left(24)
        
        let height = NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        contentView.addConstraints([height])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        contentView.layer.borderColor = UIColor.green.cgColor
        contentView.layer.borderWidth = 1
        
        contentView.layout(messageLabel)
            .top(16)
            .left(16)
            .right(16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20) as Any,
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
        messageLabel.attributedText = NSAttributedString(string: messageAlert, attributes: attributes)
        contentView.layout(closeButton)
            .below(messageLabel, 24)
            .centerX()
            .bottom(16).width(150).height(40)
        closeButton.backgroundColor = UIColor.red.withAlphaComponent(0.4)
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: closeAlert)
    }
}
