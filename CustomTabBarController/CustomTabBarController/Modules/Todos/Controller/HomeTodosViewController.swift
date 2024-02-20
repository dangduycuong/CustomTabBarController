//
//  HomeTodosViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class HomeTodosViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeTodosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerCell(TodoTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getListTodo { [weak self] in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }

    @IBAction func addTodoButtonClicked(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(.todo).viewController(of: TodoInfoViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeTodosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: TodoTableViewCell.self, forIndexPath: indexPath)
        cell.fillData(todo: viewModel.listTodo[indexPath.row])
        return cell
    }
    
    
}
