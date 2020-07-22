//
//  RequestManager.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import Connectivity

class RequestManager: ConnectivityNotifiable {
    var connectivity: Connectivity = Connectivity()
    
    static let shared = RequestManager()
    
    func connectivityChanged(toStatus: ConnectivityStatus) {
        switch toStatus {

        case .connected,
             .connectedViaWiFi,
             .connectedViaCellular:
             print("Connected")
        case .notConnected,
             .connectedViaWiFiWithoutInternet,
             .connectedViaCellularWithoutInternet:
            print("Not connected")
        case .determining:
            print("Determining connectivity")
        }
    }
}
