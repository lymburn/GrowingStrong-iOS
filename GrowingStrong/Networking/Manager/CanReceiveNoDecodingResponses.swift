//
//  NetworkManagerType.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-05.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

protocol CanReceiveNoDecodingResponses {
    func handleNoDecodingResponse(response: URLResponse?, error: Error?, completion: @escaping (String?) -> ())
}

extension CanReceiveNoDecodingResponses {
    func handleNoDecodingResponse(response: URLResponse?, error: Error?, completion: @escaping (String?) -> ()) {
        if error != nil {
            completion(NetworkResponse.generalError.rawValue)
        }
        
        if let response = response as? HTTPURLResponse {
            let result = NetworkResponseHandler.handleResponse(response)

            switch result {
            case .success:
                completion(nil)
            case.failure(let networkFailureError):
                completion(networkFailureError)
            }
        }
    }
}

