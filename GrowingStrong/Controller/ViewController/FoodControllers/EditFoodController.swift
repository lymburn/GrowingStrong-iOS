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
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveEditingFoodButtonPressed), for: .touchDown)
        return button
    }()
}

extension EditFoodController {
    fileprivate func saveFoodInfo() {
        //TO DO: implement persistence for food view model
        let servingAmount = super.getServingAmount()
        
        if selectedServing == nil || servingAmount == nil {
            print("Selected serving option or serving amount is nil")
            return
        }
        
        if let selectedServingSize = selectedServing, let servingAmount = servingAmount {
            foodEntryViewModel.selectedServing = selectedServingSize
            foodEntryViewModel.servingAmount = servingAmount
        }
    }
    
    @objc func saveEditingFoodButtonPressed() {
        saveFoodInfo()
        navigationController?.popViewController(animated: true)
    }
}
