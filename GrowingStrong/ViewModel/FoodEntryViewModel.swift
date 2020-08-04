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
    
    var totalQuantity: Float
    var totalQuantityText: String
    var totalCalories: Float
    var totalCaloriesText: String
    var shortTotalCaloriesText: String
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
        self.totalQuantity = selectedServing.quantity * self.servingAmount
        self.totalQuantityText = "\(self.totalQuantity.toOneDecimalString) \(selectedServing.unit)"
        self.totalCalories = selectedServing.kcal * self.servingAmount
        self.totalCaloriesText = "\(self.totalCalories.clean) kcal"
        self.shortTotalCaloriesText = "\(self.totalCalories.clean)"

        self.totalCarbohydrates = servingAmount * selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates.toOneDecimalString) g"
        self.totalFatText = "Fat - \(totalFat.toOneDecimalString) g"
        self.totalProteinText = "Protein - \(totalProtein.toOneDecimalString) g"
    }
    
    //Food entry VM created from food with passed in arguments for dateAdded, selectedServing, and servingAmount
    init (food: Food, dateAdded: Date, selectedServing: Serving, servingAmount: Float) {
        self.foodEntryId = UUID()
        self.food = food
        self.dateAdded = dateAdded
        self.selectedServing = selectedServing
        self.servingAmount = servingAmount
        
        self.totalQuantity = selectedServing.quantity * self.servingAmount
        self.totalQuantityText = "\(self.totalQuantity.toOneDecimalString) \(selectedServing.unit)"
        self.totalCalories = selectedServing.kcal * self.servingAmount
        self.totalCaloriesText = "\(self.totalCalories.clean) kcal"
        self.shortTotalCaloriesText = "\(self.totalCalories.clean)"
        
        self.totalCarbohydrates = servingAmount * selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates.toOneDecimalString) g"
        self.totalFatText = "Fat - \(totalFat.toOneDecimalString) g"
        self.totalProteinText = "Protein - \(totalProtein.toOneDecimalString) g"
    }
    
    private mutating func calculateNutritionInfo() {
        self.totalQuantity = selectedServing.quantity * self.servingAmount
        self.totalQuantityText = "\(self.totalQuantity.toOneDecimalString) \(selectedServing.unit)"
        self.totalCalories = selectedServing.kcal * self.servingAmount
        self.totalCaloriesText = "\(self.totalCalories.clean) kcal"
        self.shortTotalCaloriesText = "\(self.totalCalories.clean)"
        
        self.totalCarbohydrates = servingAmount * selectedServing.carb
        self.totalFat = self.servingAmount * self.selectedServing.fat
        self.totalProtein = self.servingAmount * self.selectedServing.protein
        self.totalCarbohydratesText = "Carbohydrates - \(totalCarbohydrates.toOneDecimalString) g"
        self.totalFatText = "Fat - \(totalFat.toOneDecimalString) g"
        self.totalProteinText = "Protein - \(totalProtein.toOneDecimalString) g"
    }
}
