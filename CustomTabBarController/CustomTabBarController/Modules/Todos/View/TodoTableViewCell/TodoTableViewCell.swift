//
//  TodoTableViewCell.swift
//  CustomTabBarController
//
//  Created by cuongdd on 19/04/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var todo = TodoModel()
    var changeStatus: ((TodoModel) -> Void)?
    
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
        checkBoxButton.setTitle("", for: .normal)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.green.cgColor
        containerView.layer.cornerRadius = 4
        selectionStyle = .none
    }
    
    func fillData(todo: TodoModel, keyWord: String?) {
        self.todo = todo
        
        let completed = todo.completed
        if completed {
            let image = R.image.check()?.withRenderingMode(.alwaysTemplate)
            checkImageView.image = image
            checkImageView.tintColor = UIColor.green
        } else {
            checkImageView.image = nil
        }
        
        checkImageView.layer.borderWidth = 1
        checkImageView.layer.borderColor = UIColor.green.cgColor
        checkImageView.layer.cornerRadius = 4
        
        guard let keyWord = keyWord else { return }
        let rangeTitle = findRange(source: todo.titleTodo.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeTitle.location != NSNotFound {
            setColorTextLabel(string:  todo.titleTodo, range: rangeTitle, label: titleLabel)
        } else {
            titleLabel.text = todo.titleTodo
        }
        
        let rangeContent = findRange(source: todo.descriptionTodo.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string:  todo.descriptionTodo, range: rangeContent, label: descriptionLabel)
        } else {
            descriptionLabel.text = todo.descriptionTodo
        }
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange, label: UILabel) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
    
    @IBAction func checkBoxClicked(_ sender: Any) {
        changeStatus?(todo)
    }
    
}
