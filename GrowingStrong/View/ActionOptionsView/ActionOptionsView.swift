//
//  ActionOptionsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol ActionOptionsViewDelegate: class {
    func addFoodButtonPressed()
}

class ActionOptionsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    weak var delegate: ActionOptionsViewDelegate?
    
    lazy var addFoodButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: ImageNameConstants.ActionOption.foodIcon), for: .normal)
        button.addTarget(self, action: #selector(addFoodButtonPressed), for: .touchDown)
        return button
    }()
    
    let addFoodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add food"
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension ActionOptionsView {
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(addFoodLabel)
        addSubview(addFoodButton)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        addFoodButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addFoodButton.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        addFoodButton.widthAnchor.constraint(equalToConstant: SizeConstants.actionOptionSize.width).isActive = true
        addFoodButton.heightAnchor.constraint(equalToConstant: SizeConstants.actionOptionSize.height).isActive = true
        
        addFoodLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addFoodLabel.topAnchor.constraint(equalTo: addFoodButton.bottomAnchor, constant: 8).isActive = true
    }
}

extension ActionOptionsView {
    @objc func addFoodButtonPressed() {
        delegate?.addFoodButtonPressed()
    }
}
