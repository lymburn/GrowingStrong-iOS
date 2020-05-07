//
//  LoginView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class LoginView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        return image
    }()
    
    let loginContentView: LoginContentView = {
        var view = LoginContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Setup
extension LoginView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(logo)
        addSubview(loginContentView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        logo.topAnchor.constraint(equalTo: topAnchor, constant: Constants.ScreenSize.height * 0.1).isActive = true
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.3).isActive = true
        logo.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.3).isActive = true
        
        loginContentView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50).isActive = true
        loginContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        loginContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        loginContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
