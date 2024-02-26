//
//  MealTableViewCell.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Kingfisher

class MealTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // Custom properties for your cell's UI elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize UI elements and add them to the cell's content view
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        selectionStyle = .none
        self.layout(containerView)
            .top()
            .left(16)
            .bottom(16)
            .right(16)
            .height(64)
        
        containerView.layer.borderColor = UIColor.green.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 4
        
        let vStackView = UIStackView()
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        
        containerView.layout(vStackView)
            .left(8)
            .centerY()
        
        containerView.layout(thumbnailImageView)
            .top(4)
            .after(vStackView, 8)
            .bottom(4)
            .right(4)
            .aspect(1)
    }
    
    // MARK: - Configure Cell
    
    func configure(title: String?, description: String?, strMealThumb: String?, keyWord: String) {
        // Configure UI elements with data
        if let title = title {
            titleLabel.isHidden = false
            hilightText(searchText: keyWord, content: title, label: titleLabel, color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 20))
        } else {
            titleLabel.isHidden = true
        }
        
        if let description = description {
            descriptionLabel.isHidden = false
            hilightText(searchText: keyWord, content: description, label: descriptionLabel, color: UIColor.black, font: UIFont.systemFont(ofSize: 20))
        } else {
            descriptionLabel.isHidden = true
        }
        
        guard let strMealThumb = strMealThumb else { return }
        guard let url = URL(string: strMealThumb) else { return }
        let processor = DownsamplingImageProcessor(size: thumbnailImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: thumbnailImageView.bounds.size.width / 2)
        thumbnailImageView.kf.indicatorType = .activity
        thumbnailImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func hilightText(searchText: String?, content: String?, label: UILabel, color: UIColor, font: UIFont?) {
        guard let content = content else { return }
        guard let keyWord = searchText else { return }
        let rangeContent = findRange(source: content , textToFind: keyWord.folded.lowercased())
        if rangeContent.location != NSNotFound {
            setColorTextLabel(string: content, range: rangeContent, label: label, color: color, font: font)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = .left
            let attributes: [NSAttributedString.Key : Any] = [
                .font: font as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: color
            ]
            
            label.attributedText = NSAttributedString(string: content, attributes: attributes)
        }
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange, label: UILabel, color: UIColor, font: UIFont?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font as Any,
            .foregroundColor: color
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
}

