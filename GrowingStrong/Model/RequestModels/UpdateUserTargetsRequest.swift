//
//  UpdateUserTargetsRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct UpdateUserTargetsRequest: RequestModel, CanGenerateParameters {
    var requestId: UUID
    
    let userId: Int
    let goalWeight: Float
    let weightGoalTimeline: String
    
    init(userId: Int,targets: UserTargets) {
        self.requestId = UUID()
        self.userId = userId
        self.goalWeight = targets.goalWeight
        self.weightGoalTimeline = targets.weightGoalTimeline
    }
    
    func generateParameters() -> Parameters {
        let parameters: Parameters = ["GoalWeight": goalWeight,
                                      "WeightGoalTimeline": weightGoalTimeline]
        
        return parameters
    }
}
