//
//  MealIngredientViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class MealIngredientViewController: BaseViewController {
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
    private var viewModel = MealIngredientViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        viewModel.getListAllIngredients()
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
        
        addTitle("Ingredient")
        view.layout(tableView)
            .below(titleLabel, 32)
            .left()
            .bottomSafe()
            .right()
    }
    
    private func addObserver() {
        viewModel.ingredientsDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] decals in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
    
    @objc private func updateData() {
        viewModel.getListAllIngredients()
    }
    
}

extension MealIngredientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredientsDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MealTableViewCell.self, forIndexPath: indexPath)
        let ingredient = viewModel.ingredientsDataSource.value[indexPath.row]
        cell.configure(title: ingredient.strIngredient, description: ingredient.strDescription, strMealThumb: ingredient.strCategoryThumb)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ListMealsViewController()
        vc.mealModel = viewModel.ingredientsDataSource.value[indexPath.row]
        vc.mealType = .ingredient
        navigationController?.pushViewController(vc, animated: true)
    }
}
