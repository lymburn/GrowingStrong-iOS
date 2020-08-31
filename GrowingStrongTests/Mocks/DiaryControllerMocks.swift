//
//  DiaryControllerMocks.swift
//  GrowingStrongTests
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

@testable import GrowingStrong

class MockDateBar: DateBarType {
    var dateValue: String?
    
    func getDateValue() -> String {
        return "January 01, 2020"
    }
    
    func setDateValue(text: String?) {
        dateValue = text
    }
}

class MockDailyNutritionView: DailyNutritionViewType {
    func setCaloriesValueLabel(_ text: String) {
        
    }
    
    func setCarbsValueLabel(_ text: String) {
        
    }
    
    func setFatValueLabel(_ text: String) {
        
    }
    
    func setProteinValueLabel(_ text: String) {
        
    }
    
    func getCaloriesValueLabel() -> String {
        return ""
    }
    
    func getCarbsValueLabel() -> String {
        return ""
    }
    
    func getFatValueLabel() -> String {
        return ""
    }
    
    func getProteinValueLabel() -> String {
        return ""
    }
}
