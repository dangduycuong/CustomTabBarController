//
//  HomeTodosViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class HomeTodosViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(TodoTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    private lazy var searchTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 4
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addTodoButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel = HomeTodosViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = viewModel.listTodo
        tableView.reloadData()
    }
    
    private func prepareForViewController() {
        addBackground()
        addTitle("Công Việc")
        
        view.layout(searchTextField)
            .below(titleLabel, 32)
            .left(16)
            .right(16)
            .height(40)
        
        view.layout(tableView)
            .below(searchTextField, 16)
            .left().bottomSafe().right()
        
        view.layout(addButton)
            .right(16)
            .bottomSafe(16)
            .width(44).height(44)
        
        let image = R.image.add()?.withRenderingMode(.alwaysTemplate)
        
        addButton.setBackgroundImage(image, for: .normal)
        addButton.setBackgroundImage(image, for: .highlighted)
        addButton.tintColor = UIColor.green
        
        // Setup Refresh Control
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        
    }
    
    @objc private func updateData() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func addTodoButtonClicked(_ sender: UIButton) {
        let vc = TodoInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeTodosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: TodoTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(todo: viewModel.displayTodos[indexPath.row], keyWord: viewModel.searchText)
        cell.changeStatus = { [weak self] todo in
            guard let `self` = self else { return }
            let newTodo = TodoModel()
            newTodo.idTodo = todo.idTodo
            newTodo.titleTodo = todo.titleTodo
            newTodo.descriptionTodo = todo.descriptionTodo
            newTodo.completed = !todo.completed
            _ = DataManager.shared.editTodo(newTodo: newTodo)
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            _ = DataManager.shared.removeTodo(idTodo: viewModel.listTodo[indexPath.row].idTodo)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoInfoViewController()
        vc.todo = viewModel.displayTodos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeTodosViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchText = textField.text
        tableView.reloadData()
    }
}
