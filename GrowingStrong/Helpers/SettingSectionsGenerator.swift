//
//  SettingSectionsGenerator.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-01.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

class SettingSectionsGenerator {
    static private var dateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.longMonthDefault)
    
    static func generateSections(for user: User) -> [SettingSection] {
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
        
        return sections
    }
}
