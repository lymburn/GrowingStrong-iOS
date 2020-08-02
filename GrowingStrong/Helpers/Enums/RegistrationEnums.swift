//
//  MeasurementUnit.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-15.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum WeightGoal: String {
    case gain = "Gain"
    case maintain = "Maintain"
    case lose = "Lose"
}

enum WeightGoalTimeline: String, CaseIterable {
    case gainWeightWithLargeSurplus = "Gain weight (1000 kcal surplus)"
    case gainWeightWithSmallSurplus = "Gain weight (500 kcal surplus)"
    case maintainWeight = "Maintain weight"
    case loseWeightWithSmallDeficit = "Lose weight (500 kcal deficit)"
    case loseWeightWithLargeDeficit = "Lose weight (1000 kcal deficit)"
}

enum ActivityLevel: String, CaseIterable {
    case sedentary = "Sedentary"
    case light = "Light"
    case moderate = "Moderate"
    case extreme = "Extreme"
} 
