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
        
        setupViews()
        setupConstraints()
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(saveButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        saveButton.topAnchor.constraint(equalTo: servingInfoTableView.bottomAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.height * 0.05).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SizeConstants.ScreenSize.width * 0.2).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SizeConstants.ScreenSize.width * 0.2).isActive = true
    }
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
}
