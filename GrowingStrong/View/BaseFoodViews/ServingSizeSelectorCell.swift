//
//  ServingSizeCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class ServingSizeSelectorCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    let servingSizeTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Serving Size"
        return label
    }()
    
    let servingSizeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .green
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension ServingSizeSelectorCell {
    fileprivate func setupViews() {
        addSubview(servingSizeTextLabel)
        addSubview(servingSizeValueLabel)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        servingSizeTextLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        servingSizeTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        servingSizeTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        servingSizeTextLabel.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.4).isActive = true
        
        servingSizeValueLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        servingSizeValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        servingSizeValueLabel.leadingAnchor.constraint(equalTo: servingSizeTextLabel.trailingAnchor).isActive = true
        servingSizeValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
