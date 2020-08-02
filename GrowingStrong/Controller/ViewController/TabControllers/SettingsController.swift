//
//  SettingsController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

struct SettingCellInfo {
    var name: String
    var value: String?
}

struct SettingSection {
    var sectionName: String
    var settingCellInfos: [SettingCellInfo]
}

class SettingsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        settingsTableView.register(SettingCell.self, forCellReuseIdentifier: settingCellId)
    }
    
    let settingCellId = "settingsCellId"
    
    lazy var settingsTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = SizeConstants.settingsTableViewRowHeight
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.delegate = settingsDataController
        tv.dataSource = settingsDataController
        return tv
    }()
    
    lazy var settingsDataController: SettingsDataController = {
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        let user = UserDataManager.shared.fetchUser(byId: userId)!

        let sections = SettingSectionsGenerator.generateSections(for: user)
        let controller = SettingsDataController(settingCellId: settingCellId, sections: sections)
        controller.delegate = self
        return controller
    }()
    
    lazy var dateFormatter: DateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.longMonthDefault)
}

//MARK: Setup
extension SettingsController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        view.addSubview(settingsTableView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Settings table view delegate functions
extension SettingsController: SettingsDataControllerDelegate {
    func emailSettingTapped() {
        
    }
    
    func birthDateSettingTapped() {
        
    }
    
    func sexSettingTapped() {
        
    }
    
    func weightSettingTapped() {
        
    }
    
    func heightSettingTapped() {
        
    }
    
    func activityLevelSettingTapped() {
        
    }
    
    func goalWeightSettingTapped() {
        
    }
    
    func weeklyGoalSettingTapped() {
        
    }
}
