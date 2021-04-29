//
//  EditFoodController.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-18.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class EditFoodController: BaseFoodController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBarController = self.tabBarController as? MainTabBarController
        tabBarController?.hideTabBar()
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(saveButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        saveButton.topAnchor.constraint(equalTo: servingInfoTableView.bottomAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: SizeConstants.screenSize.height * 0.05).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SizeConstants.screenSize.width * 0.2).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SizeConstants.screenSize.width * 0.2).isActive = true
    }
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveEditingFoodButtonPressed), for: .touchDown)
        return button
    }()
}

extension EditFoodController {
    fileprivate func saveFoodInfo() {
        let servingAmount = super.getServingAmount()
        let selectedServing = super.foodEntryViewModel.selectedServing
        
        if let servingAmount = servingAmount {
            FoodEntryDataManager.shared.updateFoodEntryServingSize(foodEntryViewModel.foodEntryId,
                                                 servingAmount: servingAmount,
                                                 selectedServing: selectedServing)
        }
    }
    
    @objc func saveEditingFoodButtonPressed() {
        saveFoodInfo()
        navigationController?.popViewController(animated: true)
    }
}
