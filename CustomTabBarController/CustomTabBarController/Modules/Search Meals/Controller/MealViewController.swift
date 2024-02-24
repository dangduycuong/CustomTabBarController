//
//  MealViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Kingfisher

class MealViewController: BaseViewController {
    private lazy var searchTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 4
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.placeholder = "Search meal by name"
        
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(with: MealTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private var viewModel = MealViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        viewModel.searchMealByName(searchText: searchTextField.text)
    }
    
    private func prepareForDisplay() {
        addBackground()
        addTitle("Meals")
        
        view.layout(searchTextField)
            .below(titleLabel, 32)
            .left(16)
            .right(16)
            .height(40)
        
        view.layout(tableView)
            .below(searchTextField, 16)
            .left()
            .bottomSafe()
            .right()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func addObserver() {
        
        viewModel.mealsDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] decals in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
    
    @objc private func updateData() {
        viewModel.searchMealByName(searchText: searchTextField.text)
    }
    
    
}

extension MealViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MealTableViewCell.self, forIndexPath: indexPath)
        let meal = viewModel.mealsDataSource.value[indexPath.row]
        cell.configure(title: meal.strMeal, description: meal.strInstructions, strMealThumb: meal.strMealThumb, keyWord: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MealDetailViewController()
        vc.mealModel = viewModel.mealsDataSource.value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MealViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchText = searchTextField.text ?? ""
    }
}
