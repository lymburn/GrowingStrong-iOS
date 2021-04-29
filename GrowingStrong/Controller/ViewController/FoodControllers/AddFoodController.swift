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
    }

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
    
    lazy var addToDiaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add to Diary", for: .normal)
        button.addTarget(self, action: #selector(addToDiaryButtonPressed), for: .touchDown)
        return button
    }()
}

extension AddFoodController {
    fileprivate func saveFoodToDiary() {
        //TODO: implement persistence for food view model
        let servingAmount = super.getServingAmount()
        let selectedServing = super.foodEntryViewModel.selectedServing
        
        if let servingAmount = servingAmount {
            foodEntryViewModel.servingAmount = servingAmount
            foodEntryViewModel.selectedServing = selectedServing
            
            FoodEntryDataManager.shared.createFoodEntry(foodEntryId: foodEntryViewModel.foodEntryId,
                                                        food: foodEntryViewModel.food,
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
