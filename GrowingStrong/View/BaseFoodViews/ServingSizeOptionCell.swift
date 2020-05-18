//
//  ServingSizeOptionCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class ServingSizeOptionCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension ServingSizeOptionCell {
    fileprivate func setupViews() {
        addSubview(optionLabel)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        optionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
