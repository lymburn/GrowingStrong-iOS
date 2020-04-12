//
//  RegisterStatsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class RegisterStatsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let measurementUnitSelector: UISegmentedControl = {
        let items = ["Metric", "Imperial"]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension RegisterStatsView {
    fileprivate func setupViews() {
        addSubview(measurementUnitSelector)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        measurementUnitSelector.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        measurementUnitSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        measurementUnitSelector.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.4).isActive = true
    }
}
