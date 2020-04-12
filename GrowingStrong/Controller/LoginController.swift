//
//  ViewController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-03-26.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginActionsView.delegate = self
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension LoginController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


//MARK: Login actions view delegate
extension LoginController: LoginActionsViewDelegate {
    func loginButtonPressed() {
        guard let email = loginView.loginContentView.emailTextField.text else {return}
        guard let password = loginView.loginContentView.passwordTextField.text else {return}
        
        //TO DO: Check for correct formatting in email & password
        if email.isEmpty {
            //TO DO: show error in UI
            print ("Email empty")
        }
        
        if password.isEmpty {
            print ("Empty password")
        }
        
    }
    
    func registerButtonPressed() {
        print("register")
        let registerController = RegisterController()
        
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registerController, animated: true)
    }
}

