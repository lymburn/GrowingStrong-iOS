//
//  FoodEntryViewModel.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-25.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct FoodEntryViewModel{
    var foodEntryId: UUID
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
        self.foodEntryId = foodEntry.foodEntryId
        self.food = foodEntry.food
        self.dateAdded = foodEntry.dateAdded
        self.selectedServing = foodEntry.selectedServing
        self.servingAmount = foodEntry.servingAmount
        
        selectedServing = foodEntry.selectedServing
        self.totalQuantity = Int((selectedServing.quantity * self.servingAmount).rounded())
        self.totalQuantityText = "\(self.totalQuantity) \(selectedServing.unit)"
        self.totalCalories = Int((selectedServing.kcal * self.servingAmount).rounded())
        self.totalCaloriesText = "\(self.totalCalories) kcal"

        self.totalCarbohydrates = servingAmount * selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        self.totalFatText = "Fat - \(totalFat) g"
        self.totalProteinText = "Protein - \(totalProtein) g"
    }
    
    //Food entry VM created from food with passed in arguments for dateAdded, selectedServing, and servingAmount
    init (food: Food, dateAdded: Date, selectedServing: Serving, servingAmount: Float) {
        self.foodEntryId = UUID()
        self.food = food
        self.dateAdded = dateAdded
        self.selectedServing = selectedServing
        self.servingAmount = servingAmount
        
        self.totalQuantity = Int((selectedServing.quantity * self.servingAmount).rounded())
        self.totalQuantityText = "\(self.totalQuantity) \(selectedServing.unit)"
        self.totalCalories = Int((selectedServing.kcal * self.servingAmount).rounded())
        self.totalCaloriesText = "\(self.totalCalories) kcal"

        self.totalCarbohydrates = servingAmount * selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        self.totalFatText = "Fat - \(totalFat) g"
        self.totalProteinText = "Protein - \(totalProtein) g"
    }
    
    private mutating func calculateNutritionInfo() {
        self.totalQuantity = Int((self.selectedServing.quantity * self.servingAmount).rounded())
        self.totalQuantityText = "\(self.totalQuantity) \(self.selectedServing.unit)"
        self.totalCalories = Int((self.selectedServing.kcal * self.servingAmount).rounded())
        self.totalCaloriesText = "\(self.totalCalories) kcal"

        self.totalCarbohydrates = self.servingAmount * self.selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates) g"
        self.totalFatText = "Fat - \(totalFat) g"
        self.totalProteinText = "Protein - \(totalProtein) g"
    }
}
