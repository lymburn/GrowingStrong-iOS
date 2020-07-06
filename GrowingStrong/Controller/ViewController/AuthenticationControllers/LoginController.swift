//
//  ViewController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-03-26.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginView(lView)
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer)
        setupUserNetworkManager(userNetworkManager: userNetworkManager)
        setupViews()
//        
//        userNetworkManager.getUser(id: 10) { user, error in
//            if let error = error {
//                print(error)
//            }
//
//            if let user = user {
//                print(user)
//            }
//        }
//
//        let fetchRequest = NSFetchRequest<User>(entityName: EntityNames.user.rawValue)
//
//        do {
//            let users = try CoreDataManager.shared.context.fetch(fetchRequest)
//            print(users)
//        } catch let fetchError {
//            print("Failed to fetch food entries: \(fetchError)")
//        }
        
        
        
//        let params = ["EmailAddress": "test@gmail.com", "Password": "password1"]
//        userNetworkManager.authenticateUser(userAuthenticationParameters: params) {authenticateResponse, error in
//            if let error = error {
//                print(error)
//            }
//
//            if let response = authenticateResponse {
//                print(response)
//            }
//            
//            let fetchRequest = NSFetchRequest<AuthenticateResponse>(entityName: EntityNames.authenticateResponse.rawValue)
//
//            do {
//                let authenticateResponse = try CoreDataManager.shared.context.fetch(fetchRequest)
//                print(authenticateResponse.first!.user.emailAddress)
//            } catch let fetchError {
//                print("Failed to fetch food entries: \(fetchError)")
//            }
//        }
        

    }
    
    var userNetworkManager: UserNetworkManager!
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
    
    func setupUserNetworkManager(userNetworkManager: UserNetworkManager) {
        self.userNetworkManager = userNetworkManager
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
        
        let isValidEmail = AuthenticationFormatChecker.isValidEmail(email)
        let isValidPassword = AuthenticationFormatChecker.isValidPassword(password)

        if !isValidEmail {
            print ("Invalid email format")
            return
        }
        
        if !isValidPassword {
            print ("Invalid password format")
            return
        }
        
    }

    func registerButtonPressed() {
        print("register")
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registerController, animated: true)
    }
}
