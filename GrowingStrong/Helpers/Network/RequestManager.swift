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
    
    //Queue with pending requests
    private var requestsQueue : [RequestModel] = []
    
    static let shared = RequestManager()
    
    var timer: RepeatingTimer?
    
    var foodEntryNetworkHelper: FoodEntryNetworkHelper?
    
    func connectivityChanged(toStatus: ConnectivityStatus) {
        switch toStatus {

        case .connected,
             .connectedViaWiFi,
             .connectedViaCellular:
            print("Connected to network. Start polling for pending requests")
            startPollingForPendingRequests()
        case .notConnected,
             .connectedViaWiFiWithoutInternet,
             .connectedViaCellularWithoutInternet:
            print("Not connected to network. Stop polling for pending requests")
            stopPollingForPendingRequests()
        case .determining:
            print("Determining connectivity")
        }
    }
    
    func setupTimer() {
        timer = RepeatingTimer(timeInterval: 10)
        timer?.eventHandler = pollForPendingRequests
    }
    
    func startPollingForPendingRequests() {
        timer?.resume()
    }
    
    func stopPollingForPendingRequests() {
        timer?.suspend()
    }
    
    private func pollForPendingRequests() {
        if requestsQueue.isEmpty {
            print("No requests pending")
            return
        }
        
        executePendingRequests()
    }
    
    func insertRequest (_ request: RequestModel) {
        requestsQueue.append(request)
    }
    
    //TODO: Make requests synchronous
    func executePendingRequests() {
        print("Executing pending requests")
        
        for requestModel in requestsQueue {
            if let createFoodEntryRequest = requestModel as? CreateFoodEntryRequest {
                print("Create food entry request pending")
                createFoodEntry(createFoodEntryRequest: createFoodEntryRequest)
            }
            
            if let updateFoodEntryRequest = requestModel as? UpdateFoodEntryRequest {
                print("Update food entry request pending")
                updateFoodEntry(updateFoodEntryRequest: updateFoodEntryRequest)
            }
            
            if let deleteFoodEntryRequest = requestModel as? DeleteFoodEntryRequest {
                print("Delete food entry request pending")
                deleteFoodEntry(deleteFoodEntryRequest: deleteFoodEntryRequest)
            }
        }
    }
    
    private func removeRequestFromQueue(requestId: UUID) {
        if let index = requestsQueue.firstIndex(where: {$0.requestId == requestId}) {
            requestsQueue.remove(at: index)
        }
    }
}

//MARK: Helpers to execute network requests
extension RequestManager {
    private func createFoodEntry(createFoodEntryRequest: CreateFoodEntryRequest) {
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        let parameters = createFoodEntryRequest.generateParameters()
        
        foodEntryNetworkHelper?.createFoodEntry(bodyParameters: parameters, headers: header) { response in
            switch response {
            case .networkError:
                print("Error with creating food entry")
            case .success:
                print("Successfully created food entry")
                self.removeRequestFromQueue(requestId: createFoodEntryRequest.requestId)
            }
        }
    }
    
    private func updateFoodEntry(updateFoodEntryRequest: UpdateFoodEntryRequest) {
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        let parameters = updateFoodEntryRequest.generateParameters()
        let foodEntryId = updateFoodEntryRequest.foodEntryId
        
        foodEntryNetworkHelper?.updateFoodEntry(foodEntryId: foodEntryId, bodyParameters: parameters, headers: header) { response in
            switch response {
            case .networkError:
                print("Error with updating food entry")
            case .success:
                print("Successfully updated food entry")
                self.removeRequestFromQueue(requestId: updateFoodEntryRequest.requestId)
            }
        }
    }
    
    private func deleteFoodEntry(deleteFoodEntryRequest: DeleteFoodEntryRequest) {
        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
        let foodEntryId = deleteFoodEntryRequest.foodEntryId
        
        foodEntryNetworkHelper?.deleteFoodEntry(foodEntryId: foodEntryId, headers: header) { response in
            switch response {
            case .networkError:
                print("Error with deleting food entry")
            case .success:
                print("Successfully deleted food entry")
                self.removeRequestFromQueue(requestId: deleteFoodEntryRequest.requestId)
            }
        }
    }
}
