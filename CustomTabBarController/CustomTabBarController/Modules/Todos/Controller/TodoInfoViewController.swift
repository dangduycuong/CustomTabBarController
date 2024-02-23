//
//  TodoInfoViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class TodoInfoViewController: BaseViewController {
    private lazy var todoTitleTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.green.cgColor
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private lazy var todoDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.green.cgColor
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.addTarget(self, action: #selector(completedButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel = TodoInfoViewModel()
    var todo: TodoModel?
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle("To")
        addBackButton()
        view.layout(todoTitleTextField)
            .below(titleLabel, 32).left(16).right(16).height(40)
        view.layout(todoDescriptionTextView)
            .below(todoTitleTextField, 16)
            .left(16).right(16).height(UIScreen.main.bounds.height / 2)
        
        view.layout(saveButton)
            .below(todoDescriptionTextView, 32).left(16).right(16).height(40)
        
        view.layout(addButton)
            .centerY(titleLabel)
            .right(16)
            .width(32).height(32)
        
        addButton.setBackgroundImage(R.image.add()?.withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.tintColor = UIColor.green
    }
    
    @objc func addTapped(_ sender: UIButton) {
        if let titleTodo = todoTitleTextField.text,
           let descriptionTodo = todoDescriptionTextView.text {
            if let todo = todo {
                let newTodo = TodoModel()
                newTodo.idTodo = todo.idTodo
                newTodo.titleTodo = titleTodo
                newTodo.descriptionTodo = descriptionTodo
                newTodo.completed = todo.completed
                _ = DataManager.shared.editTodo(newTodo: newTodo)
                showMessageAlert(message: "Thông tin đã được lưu lại!", close: {
                    
                })
                return
            }
            viewModel.createTodo(titleTodo: titleTodo, descriptionTodo: descriptionTodo, isCompleted: false)
        }
    }
    
    private func fillData() {
        if let todo = todo {
            todoTitleTextField.text = todo.titleTodo
            todoDescriptionTextView.text = todo.descriptionTodo
        }
    }
    
    @IBAction func completedButtonClicked(_ sender: UIButton) {
    }
    
}

