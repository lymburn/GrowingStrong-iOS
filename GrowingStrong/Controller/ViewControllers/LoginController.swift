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
        
        setupLoginView(lView)
        setupViews()
    }
    
    var loginView: LoginViewType!
    var registerController: RegisterController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    lazy var lView: LoginViewType = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
}

//MARK: Setup
extension LoginController {
    func setupLoginView(_ loginView: LoginViewType) {
        self.loginView = loginView
    }
    
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

//MARK: Login content view delegate
extension LoginController: LoginViewDelegate {
    func forgetPasswordButtonPressed() {
        //TODO
        print("Forget password pressed")
    }

    func loginButtonPressed() {
        let email = loginView.getEmailValue()
        let password = loginView.getPasswordValue()

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
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registerController, animated: true)
    }
}
