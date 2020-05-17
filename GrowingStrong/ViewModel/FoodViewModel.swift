//
//  FoodViewModel.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct FoodViewModel{
    let name: String
    let servingSizeQuantity: Float
    let servingSizeUnit: ServingSizeUnit
    let servingAmount: Float
    let caloriesPerServing: Float
    
    let totalQuantity: Int
    let totalQuantityText: String
    let totalCalories: Int
    let totalCaloriesText: String
    
    init(food: Food) {
        self.name = food.name
        self.servingSizeQuantity = food.servingSizeQuantity
        self.servingSizeUnit = food.servingSizeUnit
        self.servingAmount = food.servingAmount
        self.caloriesPerServing = food.caloriesPerServing
        
        totalQuantity = Int((servingSizeQuantity * servingAmount).rounded())
        totalQuantityText = "\(totalQuantity) \(servingSizeUnit.rawValue)"
        totalCalories = Int((caloriesPerServing * servingAmount).rounded())
        totalCaloriesText = "\(String(totalCalories)) kcal"
        
    }
}
