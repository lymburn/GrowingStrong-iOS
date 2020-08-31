//
//  UpdateUserProfileRequest.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct UpdateUserProfileRequest: RequestModel, CanGenerateParameters {
    var requestId: UUID
    
    let userId: Int
    let birthDate: Date
    let sex: String
    let height: Float
    let weight: Float
    let bmr: Float
    let activityLevel: String
    let tdee: Float
    
    init(userId: Int, profile: UserProfile) {
        self.requestId = UUID()
        self.birthDate = profile.birthDate
        self.userId = userId
        self.sex = profile.sex
        self.height = profile.height
        self.weight = profile.weight
        self.bmr = profile.bmr
        self.activityLevel = profile.activityLevel
        self.tdee = profile.tdee
    }
    
    func generateParameters() -> Parameters {
        let dateFormatter = DateFormatterHelper.generateDateFormatter(withFormat: DateFormatConstants.ISO8601)
        let birthDate = dateFormatter.string(from: self.birthDate)
        
        let parameters: Parameters = ["BirthDate": birthDate,
                                      "Sex": sex,
                                      "Height": height,
                                      "Weight": weight,
                                      "Bmr": bmr,
                                      "ActivityLevel": activityLevel,
                                      "Tdee": tdee]
        
        return parameters
    }
}
