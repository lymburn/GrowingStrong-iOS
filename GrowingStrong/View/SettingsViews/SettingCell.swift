//
//  SettingCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-01.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import UIKit

class SettingCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    let settingNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let settingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension SettingCell {
    fileprivate func setupViews() {
        addSubview(settingNameLabel)
        addSubview(settingValueLabel)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        settingNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        settingValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
