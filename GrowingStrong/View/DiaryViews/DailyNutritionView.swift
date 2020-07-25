//
//  DailyNutrition.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol DailyNutritionViewProtocol {
    func getCaloriesValueLabel() -> String
    func getCarbsValueLabel() -> String
    func getFatValueLabel() -> String
    func getProteinValueLabel() -> String
    func setCaloriesValueLabel(_ text: String)
    func setCarbsValueLabel(_ text: String)
    func setFatValueLabel(_ text: String)
    func setProteinValueLabel(_ text: String)
}

class DailyNutritionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calories"
        label.textAlignment = .left
        return label
    }()
    
    let carbsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carbs"
        label.textAlignment = .left
        return label
    }()
    
    let fatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fat"
        label.textAlignment = .left
        return label
    }()
    
    let proteinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Protein"
        label.textAlignment = .left
        return label
    }()
    
    let caloriesValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0 / 2000 kcal"
        label.textAlignment = .left
        return label
    }()
    
    let carbsValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0 / 100.0 g"
        label.textAlignment = .left
        return label
    }()
    
    let fatValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0 / 60.0 g"
        label.textAlignment = .left
        return label
    }()
    
    let proteinValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0 / 89.8 g"
        label.textAlignment = .left
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension DailyNutritionView {
    fileprivate func setupViews() {
        backgroundColor = .white
        
        addSubview(caloriesLabel)
        addSubview(carbsLabel)
        addSubview(fatLabel)
        addSubview(proteinLabel)
        addSubview(caloriesValueLabel)
        addSubview(carbsValueLabel)
        addSubview(fatValueLabel)
        addSubview(proteinValueLabel)
        
        setupConstraints()
    }

    fileprivate func setupConstraints() {
        caloriesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        caloriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        caloriesLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.6).isActive = true
        
        carbsLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 8).isActive = true
        carbsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        carbsLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.6).isActive = true
        
        fatLabel.topAnchor.constraint(equalTo: carbsLabel.bottomAnchor, constant: 8).isActive = true
        fatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        fatLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.6).isActive = true
        
        proteinLabel.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: 8).isActive = true
        proteinLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        proteinLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.6).isActive = true
        
        caloriesValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        caloriesValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        caloriesValueLabel.leadingAnchor.constraint(equalTo: caloriesLabel.trailingAnchor).isActive = true
        
        carbsValueLabel.topAnchor.constraint(equalTo: caloriesValueLabel.bottomAnchor, constant: 8).isActive = true
        carbsValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        carbsValueLabel.leadingAnchor.constraint(equalTo: carbsLabel.trailingAnchor).isActive = true
        
        fatValueLabel.topAnchor.constraint(equalTo: carbsValueLabel.bottomAnchor, constant: 8).isActive = true
        fatValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        fatValueLabel.leadingAnchor.constraint(equalTo: fatLabel.trailingAnchor).isActive = true
        
        proteinValueLabel.topAnchor.constraint(equalTo: fatValueLabel.bottomAnchor, constant: 8).isActive = true
        proteinValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        proteinValueLabel.leadingAnchor.constraint(equalTo: proteinLabel.trailingAnchor).isActive = true
    }
}

//MARK: DailyNutritionViewProtocol
extension DailyNutritionView: DailyNutritionViewProtocol {
    func getCaloriesValueLabel() -> String {
        return caloriesValueLabel.text ?? ""
    }
    
    func getCarbsValueLabel() -> String {
        return carbsValueLabel.text ?? ""
    }
    
    func getFatValueLabel() -> String {
        return fatValueLabel.text ?? ""
    }
    
    func getProteinValueLabel() -> String {
        return proteinValueLabel.text ?? ""
    }
    
    func setCaloriesValueLabel(_ text: String) {
        caloriesValueLabel.text = text
    }
    
    func setCarbsValueLabel(_ text: String) {
        carbsValueLabel.text = text
    }
    
    func setFatValueLabel(_ text: String) {
        fatValueLabel.text = text
    }
    
    func setProteinValueLabel(_ text: String) {
        proteinValueLabel.text = text
    }
}

