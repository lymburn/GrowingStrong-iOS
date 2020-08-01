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

        let accountSectionCellInfos = [SettingCellInfo(name: "Email", value: user.emailAddress)]
        let accountSection = SettingSection(sectionName: "Account", settingCellInfos: accountSectionCellInfos)

        let birthDateString = self.dateFormatter.string(from: user.profile.birthDate)
        let profileSectionCellInfos = [SettingCellInfo(name: "Birth Date", value: birthDateString),
                                       SettingCellInfo(name: "Sex", value: user.profile.sex),
                                       SettingCellInfo(name: "Weight", value: "\(user.profile.weight) kg"),
                                       SettingCellInfo(name: "Height", value: "\(user.profile.height) cm"),
                                       SettingCellInfo(name: "BMR", value: "\(user.profile.bmr.rounded()) kcal"),
                                       SettingCellInfo(name: "TDEE", value: "\(user.profile.tdee.rounded()) kcal"),
                                       SettingCellInfo(name: "Activity Level", value: "\(user.profile.activityLevel)")]
        let profileSection = SettingSection(sectionName: "Profile", settingCellInfos: profileSectionCellInfos)
        
        let targetsSectionCellInfos = [SettingCellInfo(name: "Goal Weight", value: "\(user.targets.goalWeight.toOneDecimalString) kg"),
                                       SettingCellInfo(name: "Weight Goal Timeline", value: nil)]
        let targetsSection = SettingSection(sectionName: "Targets", settingCellInfos: targetsSectionCellInfos)
        
        let sections: [SettingSection] = [accountSection, profileSection, targetsSection]
        let controller = SettingsDataController(settingCellId: settingCellId, sections: sections)
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
