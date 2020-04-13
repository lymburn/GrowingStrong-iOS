//
//  LoginContentView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol LoginContentViewDelegate: class {
    func forgetPasswordButtonPressed()
}

class LoginContentView: UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: LoginContentViewDelegate?
    
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
    
    lazy var forgetPasswordButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forget password?", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(forgetButtonPressed), for: .touchDown)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension LoginContentView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgetPasswordButton)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        forgetPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16).isActive = true
        forgetPasswordButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

//MARK: Events
extension LoginContentView {
    @objc func forgetButtonPressed() {
        delegate?.forgetPasswordButtonPressed()
    }
}
