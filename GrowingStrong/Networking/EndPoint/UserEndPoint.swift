//
//  UserEndPoint.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case dev
    case production
}

public enum UserApi {
    case user (id: Int)
}

extension UserApi : EndPointType {
    var environmentBaseURL: String {
        switch Configuration.defaultEnvironment {
        case .production: return URLConstants.Domains.prod + URLConstants.Routes.Api.user
        case .dev: return URLConstants.Domains.dev + URLConstants.Routes.Api.user
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .user(let id):
            return "\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .user(let id):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .user(let id):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
