//
//  ListMealsViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 24/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit

enum GetMealType {
    case area
    case category
    case ingredient
}

class ListMealsViewController: BaseViewController {
    
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
    private var viewModel = ListMealsViewModel()
    var mealModel: MealModel?
    var mealType = GetMealType.category
    
    override func loadView() {
        super.loadView()
        prepareForDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        loadData()
    }
    
    private func loadData() {
        switch mealType {
        case .area:
            viewModel.allMealsByArea(area: mealModel?.strArea)
        case .category:
            viewModel.getMealsByCategory(mealCategory: mealModel?.strCategory)
        case .ingredient:
            viewModel.allMealsByIngredient(ingredient: mealModel?.strIngredient)
        }
    }
    
    private func prepareForDisplay() {
        addBackground()
        switch mealType {
        case .area:
            addTitle(mealModel?.strArea ?? "")
        case .category:
            addTitle(mealModel?.strCategory ?? "")
        case .ingredient:
            addTitle(mealModel?.strIngredient ?? "")
        }
        
        addBackButton()
        
        view.layout(tableView)
            .below(titleLabel, 32)
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
        loadData()
    }
    
}

extension ListMealsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MealTableViewCell.self, forIndexPath: indexPath)
        let meal = viewModel.mealsDataSource.value[indexPath.row]
        cell.configure(title: meal.strMeal, description: meal.strInstructions, strMealThumb: meal.strMealThumb)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MealDetailViewController()
        vc.mealModel = viewModel.mealsDataSource.value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
