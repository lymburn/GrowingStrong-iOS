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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(nameLabel)
        addSubview(quantityLabel)
        addSubview(caloriesLabel)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        let height = SizeConstants.foodEntriesTableViewRowHeight
    
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: height * 0.2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        caloriesLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        caloriesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
