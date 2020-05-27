//
//  File.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

struct SizeConstants {
    static let screenSize: CGRect = UIScreen.main.bounds
    
    static let foodEntriesTableViewRowHeight: CGFloat = SizeConstants.screenSize.height * 0.08
    
    static let servingInfoTableViewRowHeight: CGFloat = SizeConstants.screenSize.height * 0.06
    
    static let servingSizeOptionsTableViewRowHeight: CGFloat = SizeConstants.screenSize.height * 0.05

    
    static let actionButtonSize = CGSize(width: 64, height: 64)
}

struct ImageNames {
    struct TabBar {
        static let diaryTab = "diary_icon"
        static let learnTab = "learn_icon"
        static let trendsTab = "trends_icon"
        static let settingsTab = "settings_icon"
    }
    
    static let actionButton = "add_icon"
    
    struct UtilityButton {
        static let rightArrow = "right_arrow"
        static let leftArrow = "left_arrow"
    }
}
