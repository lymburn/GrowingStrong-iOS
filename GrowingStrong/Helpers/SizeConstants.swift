//
//  File.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

struct SizeConstants {
    static let ScreenSize: CGRect = UIScreen.main.bounds
    
    struct DiaryView {
        static let FoodTableViewRowHeight: CGFloat = SizeConstants.ScreenSize.height * 0.08
    }
}

struct ImageNames {
    struct TabBar {
        static let diaryTab = "diary_icon"
        static let learnTab = "learn_icon"
        static let trendsTab = "trends_icon"
        static let settingsTab = "settings_icon"
        static let addIcon = "add_icon"
    }
    
    struct UtilityButton {
        static let rightArrow = "right_arrow"
        static let leftArrow = "left_arrow"
    }
}
