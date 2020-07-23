//
//  DeleteFoodEntryRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct DeleteFoodEntryRequest: RequestModel {
    var requestId: UUID
    let foodEntryId: UUID
    
    init (foodEntry: FoodEntry) {
        self.requestId = UUID()
        self.foodEntryId = foodEntry.foodEntryId
    }
}
