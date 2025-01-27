//
//  MainTabBarController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupControllerDependencies()
    }
    
    lazy var diaryController = UINavigationController(rootViewController: DiaryController())
    lazy var learnController = LearnController()
    lazy var dummyController = UIViewController()
    lazy var trendsController = TrendsController()
    lazy var settingsController = UINavigationController(rootViewController: SettingsController())
    var foodEntryViewModels: [FoodEntryViewModel] = []
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: ImageNameConstants.actionButton), for: .normal)
        button.addTarget(self, action: #selector(launchActionOptions), for: .touchDown)
        return button
    }()
    
    lazy var actionOptionsLauncher: ActionOptionsLauncher = {
        let launcher = ActionOptionsLauncher()
        launcher.delegate = self
        return launcher
    }()
    
    @objc func launchActionOptions() {
        actionOptionsLauncher.launchOptions(withDim: true)
    }
    
    func hideTabBar() {
        self.tabBar.isHidden = true
        self.actionButton.isHidden = true
    }
    
    func showTabBar() {
        self.tabBar.isHidden = false
        self.actionButton.isHidden = false
    }
}

//MARK: Setup
extension MainTabBarController {
    fileprivate func setupControllers() {
        diaryController.tabBarItem.image = UIImage(named: ImageNameConstants.TabBar.diaryTab)
        learnController.tabBarItem.image = UIImage(named: ImageNameConstants.TabBar.learnTab)
        trendsController.tabBarItem.image = UIImage(named: ImageNameConstants.TabBar.trendsTab)
        settingsController.tabBarItem.image = UIImage(named: ImageNameConstants.TabBar.settingsTab)
        
        diaryController.tabBarItem.title = "Diary"
        learnController.tabBarItem.title = "Learn"
        trendsController.tabBarItem.title = "Trends"
        settingsController.tabBarItem.title = "Settings"
        
        viewControllers = [diaryController, learnController, dummyController, trendsController, settingsController]
    }
    
    fileprivate func setupControllerDependencies() {
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        
        guard let currentUser = UserDataManager.shared.fetchUser(byId: userId) else { return }
        
        if let rootDiaryController = diaryController.rootViewController as? DiaryController {
            rootDiaryController.currentUser = currentUser
            rootDiaryController.foodEntryViewModels = self.foodEntryViewModels
        }
        let rootSettingsController = settingsController.rootViewController as! SettingsController
        
        rootSettingsController.currentUser = currentUser
    }
    
    fileprivate func setupViews() {
        view.addSubview(actionButton)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: SizeConstants.actionButtonSize.width).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: SizeConstants.actionButtonSize.height).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension MainTabBarController: ActionOptionsLauncherDelegate {
    func addFoodButtonPressed() {
        let nav = UINavigationController(rootViewController: FoodSearchController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}
