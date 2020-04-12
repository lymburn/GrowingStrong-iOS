//
//  LoginActionsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol LoginActionsViewDelegate: class {
    func loginButtonPressed()
    func registerButtonPressed()
}

class LoginActionsView: UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate : LoginActionsViewDelegate?
    
    let loginButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)
        return button
    }()
    
    let registerButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
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
extension LoginActionsView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(loginButton)
        addSubview(registerButton)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.5).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.5).isActive = true
    }
}


//MARK: Touch events
extension LoginActionsView {
    @objc func registerButtonPressed() {
        delegate?.registerButtonPressed()
    }
    
    @objc func loginButtonPressed() {
        delegate?.loginButtonPressed()
    }
}
