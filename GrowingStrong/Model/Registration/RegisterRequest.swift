//
//  RegisterRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct RegisterRequest: CanGenerateParameters {
    let email: String
    let password: String
    let birthDate: Date
    let sex: String
    let height: Float
    let weight: Float
    let activityLevel: String
    let weightGoalTimeline: String
    
    init (userAccountInfo: UserAccountInfo, userProfileAndTargetsInfo: UserProfileAndTargetsInfo) {
        self.email = userAccountInfo.email
        self.password = userAccountInfo.password
        self.birthDate = userProfileAndTargetsInfo.birthDate
        self.sex = userProfileAndTargetsInfo.sex
        self.height = userProfileAndTargetsInfo.height
        self.weight = userProfileAndTargetsInfo.weight
        self.activityLevel = userProfileAndTargetsInfo.activityLevel
        self.weightGoalTimeline = userProfileAndTargetsInfo.weightGoalTimeline
    }
    
    func generateParameters() -> Parameters {
        let dateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.ISO8601)
        let birthDate = dateFormatter.string(from: self.birthDate)
        
        let parameters: Parameters = ["EmailAddress" : email,
                                      "Password" : password,
                                      "BirthDate" : birthDate,
                                      "Sex": sex,
                                      "Height": height,
                                      "Weight": weight,
                                      "ActivityLevel": activityLevel,
                                      "WeightGoalTimeline": weightGoalTimeline]
        return parameters
    }
}
