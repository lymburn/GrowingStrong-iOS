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
    case authenticate (bodyParameters: Parameters)
    case register (bodyParameters: Parameters)
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
        case .authenticate ( _):
            return "authenticate"
        case .register ( _):
            return "register"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .user( _):
            return .get
        case .authenticate ( _):
            return .post
        case .register( _):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .user( _):
            return .request
        case .authenticate (let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .register (let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
