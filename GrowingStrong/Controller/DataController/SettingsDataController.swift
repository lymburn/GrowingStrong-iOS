//
//  SettingsDataController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-01.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class SettingsDataController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var settingCellId: String
    private var sections: [SettingSection]
    
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
}
