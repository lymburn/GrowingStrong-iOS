//
//  Food.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-17.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct Food {
    let id: Int
    let name: String
    let servingSizes: [ServingSize]
    let servingAmount: Float
    let caloriesPerServing: Float
    let carbohydratesPerServing: Float
    let fatPerServing: Float
    let proteinPerServing: Float
}
