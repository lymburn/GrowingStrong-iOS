//
//  ServingAmountCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class ServingAmountCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    let servingAmountTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Serving Amount"
        return label
    }()
    
    lazy var servingAmountValueTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .right
        tf.textColor = .green
        tf.keyboardType = .decimalPad
        tf.text = "1"
        return tf
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension ServingAmountCell {
    fileprivate func setupViews() {
        addSubview(servingAmountTextLabel)
        addSubview(servingAmountValueTextField)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        servingAmountTextLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        servingAmountTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        servingAmountTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        servingAmountTextLabel.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.4).isActive = true
        
        servingAmountValueTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        servingAmountValueTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        servingAmountValueTextField.leadingAnchor.constraint(equalTo: servingAmountTextLabel.trailingAnchor).isActive = true
        servingAmountValueTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
