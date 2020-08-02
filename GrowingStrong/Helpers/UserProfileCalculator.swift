//
//  UserProfileCalculator.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-02.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

class UserProfileCalculator {
    //Using Harris-Benedict Equation
    static func calculateBMR(sex: String, weight: Float, height: Float, age: Int) -> Float {
        var bmr: Float = 0

        if sex == Gender.male.rawValue {
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Float(age))
        } else {
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Float(age))
        }

        return bmr
    }

    static func calculateTdee(bmr: Float, activityLevel: String) -> Float {
        var tdee: Float = 0;

        switch activityLevel
        {
        case ActivityLevel.sedentary.rawValue:
            tdee = 1.2 * bmr
        case ActivityLevel.light.rawValue:
            tdee = 1.375 * bmr
        case ActivityLevel.moderate.rawValue:
            tdee = 1.55 * bmr
        case ActivityLevel.extreme.rawValue:
            tdee = 1.725 * bmr
        default:
            tdee = 0
        }

        return tdee;
    }
}
