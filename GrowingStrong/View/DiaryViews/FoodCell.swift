//
//  FoodCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    let foodIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: ImageNameConstants.ActionOption.foodIcon))
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Food name"
        label.textAlignment = .left
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 x 100g"
        label.textAlignment = .left
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100 kcal"
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup

extension FoodCell {
    fileprivate func setupViews() {
        addSubview(foodIcon)
        addSubview(nameLabel)
        addSubview(quantityLabel)
        addSubview(caloriesLabel)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        let height = SizeConstants.foodEntriesTableViewRowHeight
        
        foodIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        foodIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        foodIcon.widthAnchor.constraint(equalToConstant: height * 0.8).isActive = true
        foodIcon.heightAnchor.constraint(equalToConstant: height * 0.8).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: height * 0.2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: foodIcon.trailingAnchor, constant: 8).isActive = true
        
        quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: foodIcon.trailingAnchor, constant: 8).isActive = true
        
        caloriesLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        caloriesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
