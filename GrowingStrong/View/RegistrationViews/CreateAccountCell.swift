//
//  CreateAccountCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class CreateAccountCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let emailTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Confirm Password"
        return textField
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension CreateAccountCell {
    fileprivate func setupViews() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: SizeConstants.ScreenSize.height * 0.3).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        confirmPasswordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        confirmPasswordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
