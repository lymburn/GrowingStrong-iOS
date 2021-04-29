//
//  SettingsController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

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
        setupNavigationBar(title: "Settings", barColor: .systemBlue, titleColor: .white)
        
        settingsTableView.register(SettingCell.self, forCellReuseIdentifier: settingCellId)
        
        setupNotificationCenter()
        
        let userNetworkManager = UserNetworkManager(persistentContainer: CoreDataManager.shared.persistentContainer,
                                                    managedObjectContext: CoreDataManager.shared.backgroundContext)
        
        let userNetworkHelper = UserNetworkHelper(userNetworkManager: userNetworkManager,
                                                            jwtTokenKey: KeyChainKeys.jwtToken)
        
        RequestManager.shared.setupTimer()
        RequestManager.shared.userNetworkHelper = userNetworkHelper
        RequestManager.shared.startPollingForPendingRequests()
        RequestManager.shared.startNotifyingConnectivityChangeStatus()
    }
    
    let settingCellId = "settingsCellId"
    var currentUser: User!
    
    lazy var activityLevelOptions = ActivityLevel.allCases.map({return $0.rawValue})
    lazy var weeklyGoalOptions = WeightGoalTimeline.allCases.map({return $0.rawValue})
    lazy var sexOptions = Gender.allCases.map({return $0.rawValue})
    
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
        let sections = SettingSectionsGenerator.generateSections(for: currentUser)
        let controller = SettingsDataController(settingCellId: settingCellId, sections: sections)
        controller.delegate = self
        return controller
    }()
    
    lazy var standardOptionsLauncher: StandardOptionsLauncher = {
        let launcher = StandardOptionsLauncher()
        launcher.delegate = self
        return launcher
    }()
    
    lazy var inputSettingsLauncher: InputSettingsLauncher = {
        let launcher = InputSettingsLauncher()
        launcher.delegate = self
        return launcher
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
    
    fileprivate func setupNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: CoreDataManager.shared.mainContext)
    }
}

//MARK: Helpers
extension SettingsController {
    fileprivate func handleStandardOptionsLauncherSelection(option: String) {
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        
        if sexOptions.contains(option) {
            UserDataManager.shared.updateUserProfile(userId, birthDate: nil, sex: option, weight: nil, height: nil, activityLevel: nil)
        } else if activityLevelOptions.contains(option) {
            UserDataManager.shared.updateUserProfile(userId, birthDate: nil, sex: nil, weight: nil, height: nil, activityLevel: option)
        } else if weeklyGoalOptions.contains(option) {
            UserDataManager.shared.updateUserTargets(userId, goalWeight: nil, weightGoalTimeline: option)
        }
    }
    
    fileprivate func handleInputSettingsLauncherSave(input: Float, settingName: String) {
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        
        if settingName == SettingNames.height.rawValue {
            UserDataManager.shared.updateUserProfile(userId, birthDate: nil, sex: nil, weight: nil, height: input, activityLevel: nil)
        } else if settingName == SettingNames.weight.rawValue {
            UserDataManager.shared.updateUserProfile(userId, birthDate: nil, sex: nil, weight: input, height: nil, activityLevel: nil)
        } else if settingName == SettingNames.goalWeight.rawValue {
            UserDataManager.shared.updateUserTargets(userId, goalWeight: input, weightGoalTimeline: nil)
        }
    }
    
    fileprivate func updateSettingsTableUI() {
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        let user = UserDataManager.shared.fetchUser(byId: userId)!
        let sections = SettingSectionsGenerator.generateSections(for: user)
        
        settingsDataController.updateSections(sections: sections)
        settingsTableView.reloadData()
    }
}

//MARK: Settings table view delegate functions
extension SettingsController: SettingsDataControllerDelegate {
    func emailSettingTapped() {
        
    }
    
    func birthDateSettingTapped() {
        
    }
    
    func sexSettingTapped() {
        standardOptionsLauncher.options = sexOptions
        standardOptionsLauncher.launchOptions(withDim: true)
    }
    
    func weightSettingTapped() {
        let title = SettingNames.weight.rawValue
        let placeholder = String(currentUser.profile.weight)
        inputSettingsLauncher.setInputView(title: title, placeholder: placeholder)
        inputSettingsLauncher.launchOptions(withDim: true)
    }
    
    func heightSettingTapped() {
        let title = SettingNames.height.rawValue
        let placeholder = String(currentUser.profile.height)
        inputSettingsLauncher.setInputView(title: title, placeholder: placeholder)
        inputSettingsLauncher.launchOptions(withDim: true)
    }
    
    func activityLevelSettingTapped() {
        standardOptionsLauncher.options = activityLevelOptions
        standardOptionsLauncher.launchOptions(withDim: true)
    }
    
    func goalWeightSettingTapped() {
        let title = SettingNames.goalWeight.rawValue
        let placeholder = String(currentUser.targets.goalWeight)
        inputSettingsLauncher.setInputView(title: title, placeholder: placeholder)
        inputSettingsLauncher.launchOptions(withDim: true)
    }
    
    func weeklyGoalSettingTapped() {
        standardOptionsLauncher.options = weeklyGoalOptions
        standardOptionsLauncher.launchOptions(withDim: true)
    }
}

//MARK: Options launcher delegate
extension SettingsController: StandardOptionsLauncherDelegate {
    func didSelectOptionAtIndex(index: Int, option: String) {
        handleStandardOptionsLauncherSelection(option: option)
        standardOptionsLauncher.dismissOptions()
    }
}

//MARK: Input settings launcher delegate
extension SettingsController: InputSettingsLauncherDelegate {
    func savePressed(with input: Float, for settingName: String) {
        handleInputSettingsLauncherSave(input: input, settingName: settingName)
    }
}

extension SettingsController {
    @objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let userId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentUserIdKey)
        
        //Only monitor setting updates
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, !updates.isEmpty {
            for update in updates {
                if let profile = update as? UserProfile {
                    let request = UpdateUserProfileRequest(userId: userId, profile: profile)
                    RequestManager.shared.insertRequest(request)
                }
                
                if let targets = update as? UserTargets {
                    let request = UpdateUserTargetsRequest(userId: userId, targets: targets)
                    RequestManager.shared.insertRequest(request)
                }
                
                updateSettingsTableUI()
            }
        }
    }
}
