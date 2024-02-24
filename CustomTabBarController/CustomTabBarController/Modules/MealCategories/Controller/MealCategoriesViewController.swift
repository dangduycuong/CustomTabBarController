//
//  MealCategoriesViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class MealCategoriesViewController: BaseViewController {
    private lazy var searchTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 4
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.placeholder = "Filter by main ingredient"
        
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
    private var viewModel = MealCategoriesViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        viewModel.getMealCategories()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func prepareForDisplay() {
        addBackground()
        
        addTitle("Meal Categories")
        
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
    
    private func addObserver() {
        viewModel.mealCategoriesDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] decals in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
    
    @objc private func updateData() {
        viewModel.getMealCategories()
    }
    
}

extension MealCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealCategoriesDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MealTableViewCell.self, forIndexPath: indexPath)
        let category = viewModel.mealCategoriesDataSource.value[indexPath.row]
        cell.configure(title: category.strCategory, description: category.strCategoryDescription, strMealThumb: category.strCategoryThumb, keyWord: searchTextField.text ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListMealsViewController()
        vc.mealModel = viewModel.mealCategoriesDataSource.value[indexPath.row]
        vc.mealType = .category
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MealCategoriesViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.filterMeal(searchText: searchTextField.text)
    }
}
