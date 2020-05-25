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
    let servings: [Serving]
    
    init(food: Food) {
        self.name = food.name
        self.servings = food.servings
    }
}
