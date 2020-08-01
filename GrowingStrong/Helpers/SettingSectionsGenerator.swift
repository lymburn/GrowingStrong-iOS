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
        let accountSectionCellInfos = [SettingCellInfo(name: SettingNames.email.rawValue, value: user.emailAddress)]
        let accountSection = SettingSection(sectionName: SettingSections.account.rawValue, settingCellInfos: accountSectionCellInfos)

        let birthDateString = self.dateFormatter.string(from: user.profile.birthDate)
        let profileSectionCellInfos = [SettingCellInfo(name: SettingNames.birthDate.rawValue, value: birthDateString),
                                       SettingCellInfo(name: SettingNames.sex.rawValue, value: user.profile.sex),
                                       SettingCellInfo(name: SettingNames.weight.rawValue, value: "\(user.profile.weight) kg"),
                                       SettingCellInfo(name: SettingNames.height.rawValue, value: "\(user.profile.height) cm"),
                                       SettingCellInfo(name: SettingNames.bmr.rawValue, value: "\(user.profile.bmr.rounded()) kcal"),
                                       SettingCellInfo(name: SettingNames.tdee.rawValue, value: "\(user.profile.tdee.rounded()) kcal"),
                                       SettingCellInfo(name: SettingNames.activityLevel.rawValue, value: "\(user.profile.activityLevel)")]
        let profileSection = SettingSection(sectionName: SettingSections.profile.rawValue, settingCellInfos: profileSectionCellInfos)
        
        let targetsSectionCellInfos = [SettingCellInfo(name: SettingNames.goalWeight.rawValue,
                                                       value: "\(user.targets.goalWeight.toOneDecimalString) kg"),
                                       SettingCellInfo(name: SettingNames.weightGoalTimeline.rawValue, value: nil)]
        let targetsSection = SettingSection(sectionName: SettingSections.targets.rawValue, settingCellInfos: targetsSectionCellInfos)
        
        let sections: [SettingSection] = [accountSection, profileSection, targetsSection]
        
        return sections
    }
}
