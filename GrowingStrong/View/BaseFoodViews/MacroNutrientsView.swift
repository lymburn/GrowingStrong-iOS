//
//  MacroNutrientsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class MacroNutrientsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let carbsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let fatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let proteinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension MacroNutrientsView {
    fileprivate func setupViews() {
        addSubview(caloriesLabel)
        addSubview(carbsLabel)
        addSubview(fatLabel)
        addSubview(proteinLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        caloriesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        caloriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        carbsLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 8).isActive = true
        carbsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        carbsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        fatLabel.topAnchor.constraint(equalTo: carbsLabel.bottomAnchor, constant: 8).isActive = true
        fatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        fatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        proteinLabel.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: 8).isActive = true
        proteinLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        proteinLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
