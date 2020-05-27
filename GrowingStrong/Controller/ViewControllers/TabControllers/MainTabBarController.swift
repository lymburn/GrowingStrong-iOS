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
    
    lazy var diaryController = UINavigationController(rootViewController: DiaryController())
    lazy var learnController = LearnController()
    lazy var dummyController = UIViewController()
    lazy var trendsController = TrendsController()
    lazy var settingsController = SettingsController()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: ImageNames.actionButton), for: .normal)
        button.addTarget(self, action: #selector(launchActionOptions), for: .touchDown)
        return button
    }()
    
    lazy var actionOptionsLauncher: ActionOptionsLauncher = {
        let launcher = ActionOptionsLauncher()
        return launcher
    }()
    
    @objc func launchActionOptions() {
        actionOptionsLauncher.launchOptions(withDim: true)
    }
}

//MARK: Setup
extension MainTabBarController {
    fileprivate func setupControllers() {
        diaryController.tabBarItem.image = UIImage(named: ImageNames.TabBar.diaryTab)
        learnController.tabBarItem.image = UIImage(named: ImageNames.TabBar.learnTab)
        trendsController.tabBarItem.image = UIImage(named: ImageNames.TabBar.trendsTab)
        settingsController.tabBarItem.image = UIImage(named: ImageNames.TabBar.settingsTab)
        
        diaryController.tabBarItem.title = "Diary"
        learnController.tabBarItem.title = "Learn"
        trendsController.tabBarItem.title = "Trends"
        settingsController.tabBarItem.title = "Settings"
        
        viewControllers = [diaryController, learnController, dummyController, trendsController, settingsController]
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
