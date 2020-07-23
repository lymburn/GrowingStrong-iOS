//
//  CreateFoodEntryRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct CreateFoodEntryRequest : RequestModel, CanGenerateParameters {
    var requestId: UUID
    let userId: Int32
    let foodEntryId: UUID
    let foodId: Int32
    let dateAdded: Date
    let servingAmount: Float
    let selectedServingId: Int32
    
    init(userId: Int32, foodEntry: FoodEntry) {
        self.requestId = UUID()
        self.userId = userId
        self.foodEntryId = foodEntry.foodEntryId
        self.foodId = foodEntry.food.foodId
        self.dateAdded = foodEntry.dateAdded
        self.servingAmount = foodEntry.servingAmount
        self.selectedServingId = foodEntry.selectedServing.servingId
    }
    
    func generateParameters() -> Parameters {
        let dateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.ISO8601)
        let dateAdded = dateFormatter.string(from: self.dateAdded)
        let parameters: Parameters = ["UserId" : userId,
                                      "FoodEntryId" : foodEntryId.uuidString,
                                      "FoodId" : foodId,
                                      "DateAdded" : dateAdded,
                                      "ServingAmount" : servingAmount,
                                      "SelectedServingId" : selectedServingId]
        
        return parameters
    }
}
