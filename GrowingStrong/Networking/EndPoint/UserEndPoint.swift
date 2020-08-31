//
//  UserEndPoint.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-07.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

public enum UserApi {
    case user (id: Int)
    case authenticate (bodyParameters: Parameters)
    case register (bodyParameters: Parameters)
    case userFoodEntries (userId: Int, headers: HTTPHeaders)
    case updateUserProfile (userId: Int, bodyParameters: Parameters, headers: HTTPHeaders)
    case updateUserTargets (userId: Int, bodyParameters: Parameters, headers: HTTPHeaders)
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
        case .userFoodEntries(userId: let userId, headers: _):
            return "\(userId)/foodEntries"
        case .updateUserProfile(userId: let userId, bodyParameters: _, headers: _):
            return "\(userId)/profile"
        case .updateUserTargets(userId: let userId, bodyParameters: _, headers: _):
            return "\(userId)/targets"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .user( _):
            return .get
        case .userFoodEntries(userId: _, headers: _):
            return .get
        case .authenticate ( _):
            return .post
        case .register( _):
            return .post
        case .updateUserTargets(userId: _, bodyParameters: _, headers: _ ):
            return .put
        case .updateUserProfile(userId: _, bodyParameters: _, headers: _):
            return .put
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .user( _):
            return .request
        case .userFoodEntries(userId: _, headers: let headers):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, headers: headers)
        case .authenticate (let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .register (let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .updateUserProfile(userId: _, bodyParameters: let bodyParameters, headers: let headers):
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, headers: headers)
        case .updateUserTargets(userId: _, bodyParameters: let bodyParameters, headers: let headers):
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: nil, headers: headers)
        }
    }
}
