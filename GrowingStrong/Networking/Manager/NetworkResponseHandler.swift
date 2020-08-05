//
//  NetworkResponseHandler.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-06-08.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkResponse:String {
    case success
    case clientError = "4xx client error"
    case serverError = "5xx server error"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "Could not decode the response."
    case generalError = "General network error. Please check the network."
}

struct NetworkResponseHandler {
    static func handleResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 400...499: return .failure(NetworkResponse.clientError.rawValue)
        case 500...599: return .failure(NetworkResponse.serverError.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    static func getStatusCode(_ response: HTTPURLResponse) -> Int {
        return response.statusCode
    }
}
