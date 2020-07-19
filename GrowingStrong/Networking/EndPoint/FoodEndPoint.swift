//
//  FoodEndPoint.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-19.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

public enum FoodApi {
    case getFoodsByFullTextSearch(urlParameters: Parameters, headers: HTTPHeaders)
}

extension FoodApi : EndPointType {
    var environmentBaseURL: String {
        switch Configuration.defaultEnvironment {
        case .production: return URLConstants.Domains.prod + URLConstants.Routes.Api.food
        case .dev: return URLConstants.Domains.dev + URLConstants.Routes.Api.food
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getFoodsByFullTextSearch(_ , _):
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getFoodsByFullTextSearch(_ , _):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getFoodsByFullTextSearch(let urlParameters , let headers):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: urlParameters, headers: headers)
        }
    }
}
