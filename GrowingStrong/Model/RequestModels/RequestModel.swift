//
//  RequestModel.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

protocol CanGenerateParameters {
    func generateParameters() -> Parameters
}

protocol RequestModel {
    var requestId: UUID { get set }
}
