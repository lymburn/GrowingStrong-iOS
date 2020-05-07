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
    }
    
    lazy var diaryController = DiaryController()
    lazy var learnController = LearnController()
    lazy var actionController = ActionController()
    lazy var trendsController = TrendsController()
    lazy var settingsController = SettingsController()
    
    private func setupControllers() {
        diaryController.tabBarItem.image = UIImage(named: ImageNames.TabBar.diaryTab)
        learnController.tabBarItem.image = UIImage(named: ImageNames.TabBar.learnTab)
        actionController.tabBarItem.image = UIImage(named: ImageNames.TabBar.addIcon)?.withRenderingMode(.alwaysOriginal)
        trendsController.tabBarItem.image = UIImage(named: ImageNames.TabBar.trendsTab)
        settingsController.tabBarItem.image = UIImage(named: ImageNames.TabBar.settingsTab)
        
        diaryController.tabBarItem.title = "Diary"
        learnController.tabBarItem.title = "Learn"
        actionController.tabBarItem.title = nil
        trendsController.tabBarItem.title = "Trends"
        settingsController.tabBarItem.title = "Settings"
        
        actionController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        viewControllers = [diaryController, learnController, actionController, trendsController, settingsController]
    }
}
