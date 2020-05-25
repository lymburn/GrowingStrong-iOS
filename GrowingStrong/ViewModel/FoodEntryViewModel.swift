//
//  FoodEntryViewModel.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-25.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct FoodEntryViewModel{
    var id: Int
    var food: Food
    var dateAdded: Date
    var selectedServing: Serving {
        didSet {
            calculateNutritionInfo()
        }
    }
    
    var servingAmount: Float {
        didSet {
            calculateNutritionInfo()
        }
    }
    
    var totalQuantity: Int
    var totalQuantityText: String
    var totalCalories: Int
    var totalCaloriesText: String
    var totalCarbohydrates: Float
    var totalFat: Float
    var totalProtein: Float
    var totalCarbohydratesText: String
    var totalFatText: String
    var totalProteinText: String
    
    init(foodEntry: FoodEntry) {
        self.id = foodEntry.id
        self.food = foodEntry.food
        self.dateAdded = foodEntry.dateAdded
        self.selectedServing = foodEntry.food.servings[0]
        self.servingAmount = foodEntry.servingAmount
        
        let selectedServingSize = selectedServing.servingSize
        self.totalQuantity = Int((selectedServingSize.quantity * self.servingAmount).rounded())
        self.totalQuantityText = "\(self.totalQuantity) \(selectedServingSize.unit)"
        self.totalCalories = Int((self.selectedServing.caloriesPerServing * self.servingAmount).rounded())
        self.totalCaloriesText = "\(self.totalCalories) kcal"

        self.totalCarbohydrates = self.servingAmount * self.selectedServing.carbohydratesPerServing
        self.totalFat = self.servingAmount * self.selectedServing.fatPerServing
        self.totalProtein = self.servingAmount * self.selectedServing.proteinPerServing
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        self.totalFatText = "Fat - \(totalFat) g"
        self.totalProteinText = "Protein - \(totalProtein) g"
    }
    
    private mutating func calculateNutritionInfo() {
        let selectedServingSize = selectedServing.servingSize
        self.totalQuantity = Int((selectedServingSize.quantity * self.servingAmount).rounded())
        self.totalQuantityText = "\(self.totalQuantity) \(selectedServingSize.unit)"
        self.totalCalories = Int((self.selectedServing.caloriesPerServing * self.servingAmount).rounded())
        self.totalCaloriesText = "\(self.totalCalories) kcal"

        self.totalCarbohydrates = self.servingAmount * self.selectedServing.carbohydratesPerServing
        self.totalFat = self.servingAmount * self.selectedServing.fatPerServing
        self.totalProtein = self.servingAmount * self.selectedServing.proteinPerServing
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        self.totalFatText = "Fat - \(totalFat) g"
        self.totalProteinText = "Protein - \(totalProtein) g"
    }
}
