//
//  SettingNames.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-01.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

enum SettingNames: String {
    case email = "Email"
    case birthDate = "Birth Date"
    case sex = "Sex"
    case weight = "Weight"
    case height = "Height"
    case bmr = "BMR"
    case tdee = "TDEE"
    case activityLevel = "Activity Level"
    case goalWeight = "Goal Weight"
    case weeklyGoal = "Weekly Goal"
}

enum SettingSections: String {
    case account = "Account"
    case profile = "Profile"
    case targets = "Targets"
}
