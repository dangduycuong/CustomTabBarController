//
//  MealDetailViewController.swift
//  CustomTabBarController
//
//  Created by cuongdd on 23/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Kingfisher

class MealDetailViewController: BaseViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var mealView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var mealModel: MealModel?
    private var viewModel = MealViewModel()
    
    override func loadView() {
        super.loadView()
        prepareForDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addObserver()
        viewModel.getMealDetail(id: mealModel?.idMeal)
    }
    
    private func addObserver() {
        viewModel.mealDetailDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] meal in
            guard let `self` = self else { return }
            self.mealModel = meal
            self.fillData()
            
            let ingredientVStackView = UIStackView()
            ingredientVStackView.axis = .vertical
            ingredientVStackView.distribution = .equalSpacing
            ingredientVStackView.alignment = .fill
            
            let measureVStackView = UIStackView()
            measureVStackView.axis = .vertical
            measureVStackView.distribution = .equalSpacing
            measureVStackView.alignment = .fill
            
            mealView.layout(ingredientVStackView)
                .top(mealImageView)
                .after(mealImageView, 8)
                .bottom(mealImageView)
            
            mealView.layout(measureVStackView)
                .top(mealImageView)
                .after(ingredientVStackView, 8)
                .bottom(mealImageView)
            
            for i in 0..<self.viewModel.ingredients.count {
                let label = UILabel()
                label.text = "\(i + 1) - \(self.viewModel.ingredients[i])"
                label.font = UIFont.boldSystemFont(ofSize: 20)
                ingredientVStackView.addArrangedSubview(label)
            }
            
            for i in 0..<self.viewModel.measures.count {
                let label = UILabel()
                label.text = "\(self.viewModel.measures[i])"
                label.font = UIFont.systemFont(ofSize: 20)
                measureVStackView.addArrangedSubview(label)
            }
            
        }).disposed(by: disposeBag)
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
        addTitle(mealModel?.strMeal ?? "----")
        addBackButton()
        
        view.layout(scrollView)
            .below(titleLabel, 32)
            .left()
            .bottomSafe()
            .right()
        
        scrollView.layout(mealView)
            .top(0).left(0).bottom(0).right(0).width(view.bounds.size.width)
        
        let hight = NSLayoutConstraint(item: mealView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        mealView.addConstraints([hight])
        mealView.backgroundColor = .clear
        mealView.translatesAutoresizingMaskIntoConstraints = false
        
        mealView.layout(mealImageView)
            .top(16)
            .left(16)
            .width(view.bounds.width / 2)
            .aspect(1.0)
        
        mealImageView.layoutIfNeeded()
        mealView.layout(descriptionLabel)
            .below(mealImageView, 16)
            .left(16)
            .bottom(16)
            .right(16)
        descriptionLabel.numberOfLines = 0
    }
    
    private func fillData() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .paragraphStyle: paragraphStyle
        ]
        descriptionLabel.attributedText = NSAttributedString(string: mealModel?.strInstructions ?? "", attributes: attributes)
        
        guard let url = URL(string: mealModel?.strMealThumb ?? "https://example.com/high_resolution_image.png") else { return }
        let processor = DownsamplingImageProcessor(size: self.mealImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 4)
        self.mealImageView.kf.indicatorType = .activity
        self.mealImageView.kf.setImage(
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
                self.loadImage()
            }
        }
    }
    
    private func loadImage() {
        Utils.showLoadingIndicator(nil, true)
        guard let strMealThumb = mealModel?.strMealThumb,
              let url = URL(string: strMealThumb) else {
            Utils.hideLoadingIndicator()
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                Utils.hideLoadingIndicator()
                self.mealImageView.alpha = 1
                Task {
                    self.mealImageView.image = await image.byPreparingForDisplay()
                }
            }
        }
    }
    // MARK: - Actions
    
    
}
