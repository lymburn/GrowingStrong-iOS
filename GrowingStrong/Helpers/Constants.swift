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
    static let settingsTableViewRowHeight: CGFloat = SizeConstants.screenSize.height * 0.1
    static let actionButtonSize = CGSize(width: 64, height: 64)
    static let actionOptionSize = CGSize(width: 50, height: 50)
}

struct ImageNameConstants {
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
    
    struct ActionOption {
        static let foodIcon = "food_icon"
    }
}

struct DateFormatConstants {
    static let longMonthDefault = "MMMM dd, yyyy"
    static let shortMonthDefault = "MMM dd, yyyy"
    static let ISO8601 = "yyyy-MM-dd'T'HH:mm:ss"
}

struct URLConstants {
    struct Domains {
        static let dev = "http://localhost:5000"
        static let prod = "http://localhost:5000"
    }
    
    struct Routes {
        struct Api {
            static let user = "/api/user"
            static let foodEntry = "/api/foodEntry"
            static let food = "/api/food"
        }
    }
}

struct NetworkEncodingConstants {
    static let urlParameterContentType = "application/x-www-form-urlencoded; charset=utf-8"
    static let jsonParameterContentType = "application/json"
}

struct Configuration {
    static let defaultEnvironment: NetworkEnvironment = .dev
}

struct CoreDataConstants {
    static let dataModelName = "GrowingStrongModel"
}

struct KeyChainKeys {
    static let jwtToken = "jwtToken"
    static let unitTestJwtToken = "unitTestJwtToken"
}

struct UserDefaultsKeys {
    static let currentUserIdKey = "currentUserIdKey"
}
