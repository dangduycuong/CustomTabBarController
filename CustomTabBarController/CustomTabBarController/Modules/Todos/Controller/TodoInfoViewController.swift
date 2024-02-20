//
//  TodoInfoViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class TodoInfoViewController: UIViewController {
    @IBOutlet weak var todoTitleTextField: UITextField!
    @IBOutlet weak var todoDescriptionTextView: UITextView!
    
    var viewModel = TodoInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        if let titleTodo = todoTitleTextField.text,
           let descriptionTodo = todoDescriptionTextView.text {
            viewModel.createTodo(titleTodo: titleTodo, descriptionTodo: descriptionTodo, isCompleted: false)
        }
        
    }
    
    @IBAction func completedButtonClicked(_ sender: Any) {
    }
    
}
