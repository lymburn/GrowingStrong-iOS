//
//  DailyNutrition.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class DailyNutritionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension DailyNutritionView {
    fileprivate func setupViews() {
        backgroundColor = .white
        
        setupConstraints()
    }

    fileprivate func setupConstraints() {

    }
}

