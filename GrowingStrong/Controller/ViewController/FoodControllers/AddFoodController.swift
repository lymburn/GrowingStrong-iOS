//
//  AddFoodController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class AddFoodController: BaseFoodController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        setupViews()
        setupConstraints()
        
        let foodEntryNetworkManager = FoodEntryNetworkManager()
        let foodEntryNetworkHelper = FoodEntryNetworkHelper(foodEntryNetworkManager: foodEntryNetworkManager,
                                                            jwtTokenKey: KeyChainKeys.jwtToken)
        
        setupDependencies(foodEntryNetworkHelper: foodEntryNetworkHelper)
    }
    
    var foodEntryNetworkHelper: FoodEntryNetworkHelperType!
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(addToDiaryButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addToDiaryButton.topAnchor.constraint(equalTo: servingInfoTableView.bottomAnchor).isActive = true
        addToDiaryButton.heightAnchor.constraint(equalToConstant: SizeConstants.screenSize.height * 0.05).isActive = true
        addToDiaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SizeConstants.screenSize.width * 0.2).isActive = true
        addToDiaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SizeConstants.screenSize.width * 0.2).isActive = true
    }
    
    fileprivate func setupDependencies(foodEntryNetworkHelper: FoodEntryNetworkHelperType) {
        self.foodEntryNetworkHelper = foodEntryNetworkHelper
    }
    
    lazy var addToDiaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Add to Diary", for: .normal)
        button.addTarget(self, action: #selector(addToDiaryButtonPressed), for: .touchDown)
        return button
    }()
}

extension AddFoodController {
    fileprivate func saveFoodToDiary() {
        //TODO: implement persistence for food view model
        let servingAmount = super.getServingAmount()
        
        if selectedServing == nil || servingAmount == nil {
            print("Selected serving option or serving amount is nil")
            return
        }
        
        if let selectedServing = selectedServing, let servingAmount = servingAmount {
            foodEntryViewModel.servingAmount = servingAmount
            foodEntryViewModel.selectedServing = selectedServing
            
            FoodEntryDataManager.shared.createFoodEntry(food: foodEntryViewModel.food,
                                                 dateAdded: foodEntryViewModel.dateAdded,
                                                 servingAmount: servingAmount,
                                                 selectedServing: selectedServing)
        }
    }
    
    @objc func addToDiaryButtonPressed() {
        saveFoodToDiary()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Networking
extension AddFoodController {
    

    fileprivate func networkCreateFoodEntry() {
//        guard let header = JWTHeaderGenerator.generateHeader(jwtTokenKey: KeyChainKeys.jwtToken) else { return }
//        var parameters = foodEntryViewModel.generateCreateParameters()
//        parameters["UserId"] = UserDataManager.fetchCurrentUser()?.userId
//        foodEntryNetworkHelper.createFoodEntry(bodyParameters: parameters, headers: header) { networkResponse, createFoodEntryResponse in
//            switch networkResponse {
//            case .networkError:
//                print("Error with network creating food entry")
//            case .success:
//                if let response = createFoodEntryResponse {
//                    let createdFoodEntryId = response.foodEntryId
//
//                }
//
//            }
//        }
    }
}
