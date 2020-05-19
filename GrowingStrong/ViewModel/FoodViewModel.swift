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
    let servingSizes: [ServingSize]
    let servingAmount: Float
    let caloriesPerServing: Float
    let carbohydratesPerServing: Float
    let fatPerServing: Float
    let proteinPerServing: Float
    
    let selectedServingSize: ServingSize
    let totalQuantity: Int
    let totalQuantityText: String
    let totalCalories: Int
    let totalCaloriesText: String
    let totalCarbohydrates: Float
    let totalFat: Float
    let totalProtein: Float
    let totalCarbohydratesText: String
    let totalFatText: String
    let totalProteinText: String
    
    init(food: Food) {
        self.name = food.name
        self.servingSizes = food.servingSizes
        self.servingAmount = food.servingAmount
        self.caloriesPerServing = food.caloriesPerServing
        self.carbohydratesPerServing = food.carbohydratesPerServing
        self.fatPerServing = food.fatPerServing
        self.proteinPerServing = food.proteinPerServing
        
        selectedServingSize = servingSizes[0]
        totalQuantity = Int((selectedServingSize.quantity * servingAmount).rounded())
        totalQuantityText = "\(totalQuantity) \(selectedServingSize.unit)"
        totalCalories = Int((caloriesPerServing * servingAmount).rounded())
        totalCaloriesText = "\(totalCalories) kcal"
        
        totalCarbohydrates = servingAmount * carbohydratesPerServing
        totalFat = servingAmount * fatPerServing
        totalProtein = servingAmount * proteinPerServing
        totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        totalFatText = "Fat - \(totalFat) g"
        totalProteinText = "Protein - \(totalProtein) g"
    }
}
