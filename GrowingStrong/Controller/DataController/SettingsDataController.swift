//
//  SettingsDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-01.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol SettingsDataControllerDelegate: class {
    func emailSettingTapped()
    func birthDateSettingTapped()
    func sexSettingTapped()
    func weightSettingTapped()
    func heightSettingTapped()
    func activityLevelSettingTapped()
    func goalWeightSettingTapped()
    func weeklyGoalSettingTapped()
}

class SettingsDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var settingCellId: String
    private var sections: [SettingSection]
    
    weak var delegate: SettingsDataControllerDelegate?
    
    init(settingCellId: String, sections: [SettingSection]) {
        self.settingCellId = settingCellId
        self.sections = sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].settingCellInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: settingCellId, for: indexPath) as! SettingCell
        let section = sections[indexPath.section]
        let cellInfo = section.settingCellInfos[indexPath.row]
        
        settingCell.settingNameLabel.text = cellInfo.name
        settingCell.settingValueLabel.text = cellInfo.value
        
        return settingCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingName = sections[indexPath.section].settingCellInfos[indexPath.row].name
        
        switch settingName {
        case SettingNames.email.rawValue:
            delegate?.emailSettingTapped()
        case SettingNames.birthDate.rawValue:
            delegate?.birthDateSettingTapped()
        case SettingNames.sex.rawValue:
            delegate?.sexSettingTapped()
        case SettingNames.weight.rawValue:
            delegate?.weightSettingTapped()
        case SettingNames.height.rawValue:
            delegate?.heightSettingTapped()
        case SettingNames.activityLevel.rawValue:
            delegate?.activityLevelSettingTapped()
        case SettingNames.goalWeight.rawValue:
            delegate?.goalWeightSettingTapped()
        case SettingNames.weeklyGoal.rawValue:
            delegate?.weeklyGoalSettingTapped()
        default:
            print("Setting \(settingName) tapped")
        }
    }
    
    func updateSections(sections: [SettingSection]) {
        self.sections = sections
    }
}
