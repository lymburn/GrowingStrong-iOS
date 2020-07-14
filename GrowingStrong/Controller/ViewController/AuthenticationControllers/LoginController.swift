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
        
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer)
        let authenticationNetworkHelper = AuthenticationNetworkHelper(userNetworkManager: userNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        let userNetworkHelper = UserNetworkHelper(userNetworkManager: userNetworkManager, jwtTokenKey: KeyChainKeys.jwtToken)
        let userDataManager = UserDataManager()
        
        setupDependencies(loginView: lView,
                          authenticationNetworkHelper: authenticationNetworkHelper,
                          userNetworkHelper: userNetworkHelper,
                          userDataManager: userDataManager)
        
        CoreDataManager.shared.clearAllStorage()
        
        setupViews()
    }
    
    var authenticationNetworkHelper: AuthenticationNetworkHelperType!
    var userNetworkHelper: UserNetworkHelperType!
    var loginView: LoginViewType!
    var registerController: RegisterController!
    var userDataManager: UserDataManagerType!
    
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
    func setupDependencies(loginView: LoginViewType,
                           authenticationNetworkHelper: AuthenticationNetworkHelperType,
                           userNetworkHelper: UserNetworkHelperType,
                           userDataManager: UserDataManagerType) {
        
        self.loginView = loginView
        self.authenticationNetworkHelper = authenticationNetworkHelper
        self.userNetworkHelper = userNetworkHelper
        self.userDataManager = userDataManager
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
        authenticateUser()
    }

    func registerButtonPressed() {
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(registerController, animated: true)
    }
}

//Helpers
extension LoginController {
    fileprivate func authenticateUser() {
        let email = loginView.getEmailValue()
        let password = loginView.getPasswordValue()
        
        authenticationNetworkHelper.authenticate(email: email, password: password) { response, user in
            self.handleAuthenticationResponse(response, user)
        }
    }
    
    fileprivate func getUserFoodEntries(userId: Int) {
        userNetworkHelper.getUserFoodEntries(userId: 4) { response, foodEntries in
            switch response {
            case .success:
                self.navigateToMainPage()
            case .networkError:
                //TODO: Handle this
                print ("Error retrieving user's food entries")
            }
        }
    }
    
    fileprivate func handleAuthenticationResponse(_ response: AuthenticationNetworkHelperResponse,
                                                  _ user: User?) {
        //TODO: Do stuff with errors (e.g. UI)
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
            if let user = user {
                let userId = Int(user.userId)
                createUser(userId: userId, emailAddress: user.emailAddress)
                getUserFoodEntries(userId: userId)
            }
        }
    }
    
    fileprivate func createUser(userId: Int, emailAddress: String) {
        userDataManager.createUser(userId: userId, emailAddress: emailAddress)
    }
    
    fileprivate func navigateToMainPage() {
        DispatchQueue.main.async {
            let mainController = MainTabBarController()
            mainController.modalPresentationStyle = .fullScreen
            self.present(mainController, animated: true)
        }
    }
}
