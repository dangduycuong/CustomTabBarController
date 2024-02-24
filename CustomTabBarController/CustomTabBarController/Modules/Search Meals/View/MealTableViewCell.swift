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
    
    // Custom properties for your cell's UI elements
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let thumbnailImageView = UIImageView()
    
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
        
        containerView.layout(thumbnailImageView)
            .top(8)
            .bottom(8)
            .right(8)
            .width(48)
        
        containerView.layout(titleLabel)
            .top(8)
            .left(8)
            .before(thumbnailImageView, 8)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        containerView.layout(descriptionLabel)
            .left(8)
            .bottom(8)
            .before(thumbnailImageView, 8)
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    // MARK: - Configure Cell
    
    func configure(title: String?, description: String?, strMealThumb: String?, keyWord: String) {
        // Configure UI elements with data
        let titleDisplay = title ?? " "
        let descriptionDisplay = description ?? " "
        
        hilightColor(textDisplay: titleDisplay, keyWord: keyWord, label: titleLabel, font: UIFont.boldSystemFont(ofSize: 20))
        hilightColor(textDisplay: descriptionDisplay, keyWord: keyWord, label: descriptionLabel)
        
        guard let url = URL(string: strMealThumb ?? "https://example.com/high_resolution_image.png") else { return }
        let processor = DownsamplingImageProcessor(size: thumbnailImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
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
    
    private func hilightColor(textDisplay: String, keyWord: String, label: UILabel, font: UIFont? = UIFont.systemFont(ofSize: 20)) {
        let rangeDescription = findRange(source: textDisplay.folded.lowercased(), textToFind: keyWord.folded.lowercased())
        if rangeDescription.location != NSNotFound {
            setColorTextLabel(string: textDisplay, range: rangeDescription, label: label)
        } else {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 6
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font as Any,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
            label.attributedText = NSAttributedString(string: textDisplay, attributes: attributes)
        }
    }
    
    func findRange(source: String, textToFind: String) -> NSRange {
        let string = NSMutableAttributedString(string: source.folded.lowercased())
        
        let range = string.mutableString.range(of: textToFind.folded.lowercased(), options: .caseInsensitive)
        return range
    }
    
    func setColorTextLabel(string: String, range: NSRange, label: UILabel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: attributes)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        label.attributedText = myMutableString
    }
}

