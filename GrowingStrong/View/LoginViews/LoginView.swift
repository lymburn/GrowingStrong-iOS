//
//  LoginView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol LoginViewProtocol {
    func getEmailValue() -> String
    func getPasswordValue() -> String
}

protocol LoginViewDelegate: class {
    func forgetPasswordButtonPressed()
    func loginButtonPressed()
    func registerButtonPressed()
}

class LoginView: UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: LoginViewDelegate?
    
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
        textField.isSecureTextEntry = true
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
    
    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchDown)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension LoginView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgetPasswordButton)
        addSubview(loginButton)
        addSubview(registerButton)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: SizeConstants.screenSize.height * 0.3).isActive = true
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
        
        loginButton.topAnchor.constraint(equalTo: forgetPasswordButton.bottomAnchor, constant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.8).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: SizeConstants.screenSize.width * 0.8).isActive = true
    }
}

//MARK: Events
extension LoginView {
    @objc func forgetButtonPressed() {
        delegate?.forgetPasswordButtonPressed()
    }
    
    @objc func registerButtonPressed() {
        delegate?.registerButtonPressed()
    }
    
    @objc func loginButtonPressed() {
        delegate?.loginButtonPressed()
    }
}

//MARK: LoginViewProtocol implementation
extension LoginView: LoginViewProtocol {
    func getEmailValue() -> String {
        return emailTextField.text ?? ""
    }
    
    func getPasswordValue() -> String {
        return passwordTextField.text ?? ""
    }
}
