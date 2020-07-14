//
//  ViewController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-03-26.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData
import SwiftKeychainWrapper
class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginView(lView)
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer)
        setupAuthenticationNetworkHelper(authenticationNetworkHelper: AuthenticationNetworkHelper(userNetworkManager: userNetworkManager,
                                                                             jwtTokenKey: KeyChainKeys.jwtToken))
        
        userNetworkHelper = UserNetworkHelper(userNetworkManager: userNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupViews()
    }
    
    var authenticationNetworkHelper: AuthenticationNetworkHelperType!
    var userNetworkHelper: UserNetworkHelperType!
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
    
    func setupAuthenticationNetworkHelper(authenticationNetworkHelper: AuthenticationNetworkHelperType) {
        self.authenticationNetworkHelper = authenticationNetworkHelper
    }

    func loginButtonPressed() {
        let email = loginView.getEmailValue()
        let password = loginView.getPasswordValue()
        
        authenticationNetworkHelper.authenticate(email: email, password: password) { response in
            switch response {
            case .invalidEmailFormat:
                print ("Invalid email format")
            case .invalidPasswordFormat:
                print ("Invalid password format")
            case .authenticationError:
                print ("Authentication error")
            case .networkError:
                print ("Network error")
            case .savingTokenError:
                print ("Error saving token")
            case .success:
                self.navigateToMainPage()
            }
        }
        
        userNetworkHelper.getUserFoodEntries(userId: 4) { response, foodEntries in
            if response == .success {
                print (foodEntries)
            }
        }
    }

    func registerButtonPressed() {
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registerController, animated: true)
    }
}

extension LoginController {
    fileprivate func navigateToMainPage() {
        DispatchQueue.main.async {
            let mainController = MainTabBarController()
            mainController.modalPresentationStyle = .fullScreen
            self.present(mainController, animated: true)
        }
    }
}
