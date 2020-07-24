//
//  FoodEntryEndPoint.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

public enum FoodEntryApi {
    case update (foodEntryId: UUID, bodyParameters: Parameters, headers: HTTPHeaders)
    case delete (foodEntryId: UUID, headers: HTTPHeaders)
    case create (bodyParameters: Parameters, headers: HTTPHeaders)
}

extension FoodEntryApi : EndPointType {
    var environmentBaseURL: String {
        switch Configuration.defaultEnvironment {
        case .production: return URLConstants.Domains.prod + URLConstants.Routes.Api.foodEntry
        case .dev: return URLConstants.Domains.dev + URLConstants.Routes.Api.foodEntry
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .create( _, _):
            return ""
        case .update(let foodEntryId, _, _):
            return "\(foodEntryId)"
        case .delete(let foodEntryId, _):
            return "\(foodEntryId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create( _, _):
            return .post
        case .update(_, _, _):
            return .put
        case .delete(_, _):
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let bodyParameters, let headers):
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, headers: headers)
        case .update( _, let bodyParameters, let headers):
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, headers: headers)
        case .delete(_, let headers):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, headers: headers)
        }
    }
}
