//
//  UpdateFoodEntryRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct UpdateFoodEntryRequest: RequestModel, CanGenerateParameters {
    var requestId: UUID
    let foodEntryId: UUID
    let servingAmount: Float
    let selectedServingId: Int32
    
    init(foodEntry: FoodEntry) {
        self.requestId = UUID()
        self.foodEntryId = foodEntry.foodEntryId
        self.servingAmount = foodEntry.servingAmount
        self.selectedServingId = foodEntry.selectedServing.servingId
    }
    
    func generateParameters() -> Parameters {
        let parameters: Parameters = ["ServingAmount" : servingAmount,
                                      "SelectedServingId" : selectedServingId]
        
        return parameters
    }
    
    
}
