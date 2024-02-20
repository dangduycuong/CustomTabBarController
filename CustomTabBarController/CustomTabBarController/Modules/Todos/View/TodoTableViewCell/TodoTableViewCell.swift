//
//  TodoTableViewCell.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        checkBoxButton.setTitle(nil, for: .normal)
    }
    
    func fillData(todo: TodoModel) {
        titleLabel.text = todo.titleTodo
        descriptionLabel.text = todo.descriptionTodo
    }
    
    @IBAction func checkBoxClicked(_ sender: Any) {
        print("change status")
    }
    
}
