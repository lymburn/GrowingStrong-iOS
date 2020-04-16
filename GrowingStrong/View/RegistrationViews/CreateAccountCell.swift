//
//  CreateAccountCell.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-16.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class CreateAccountCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension CreateAccountCell {
    fileprivate func setupViews() {
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
    }
}
