//
//  ConnectivityNotifiable.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import Connectivity

//Protocol for notifying objects of connectivity change
protocol ConnectivityNotifiable {
    var connectivity: Connectivity { get }
    func startNotifyingConnectivityChangeStatus()
    func stopNotifyingConnectivityChangeStatus()
    func connectivityChanged(toStatus: ConnectivityStatus)
}

// Provide some default implementation through protocol extension
extension ConnectivityNotifiable {
    func startNotifyingConnectivityChangeStatus() {
        connectivity.isPollingEnabled = true
        connectivity.startNotifier()
        connectivity.whenConnected = { connectivity in
            self.connectivityChanged(toStatus: connectivity.status)
        }
        connectivity.whenDisconnected = { connectivity in
            self.connectivityChanged(toStatus: connectivity.status)
        }
    }
    func stopNotifyingConnectivityChangeStatus() {
        connectivity.stopNotifier()
    }
}
