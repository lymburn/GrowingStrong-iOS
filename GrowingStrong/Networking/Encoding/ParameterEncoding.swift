//
//  ParameterEncoding.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil"
}

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode (urlRequest: inout URLRequest, with parameters: Parameters) throws
}
