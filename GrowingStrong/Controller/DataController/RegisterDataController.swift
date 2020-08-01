//
//  RegisterDataSourceProvider.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol RegisterDataControllerDelegate: class {
    func heightValueDidChange(to height: Double)
    func weightValueDidChange(to weight: Double)
    func weightGoalDidChange(to goal: WeightGoal)
    func birthdayFieldSelected()
    func activityLevelDidChange(to level: ActivityLevel)
}

class RegisterDataController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let registerStatsCellId: String
    private let createAccountCellId: String
    private var dateFormatter: DateFormatter
    
    weak var delegate: RegisterDataControllerDelegate?
    
    init(registerStatsCellId: String, createAccountCellId: String, dateFormatter: DateFormatter) {
        self.registerStatsCellId = registerStatsCellId
        self.createAccountCellId = createAccountCellId
        self.dateFormatter = dateFormatter
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let registerStatsCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerStatsCellId, for: indexPath) as! RegisterStatsCell
            registerStatsCell.birthdayTextField.text = dateFormatter.getCurrentDateString()
            registerStatsCell.delegate = self
            return registerStatsCell
        } else {
            let createAccountCell = collectionView.dequeueReusableCell(withReuseIdentifier: createAccountCellId, for: indexPath) as! CreateAccountCell
            return createAccountCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension RegisterDataController: RegisterStatsCellDelegate {
    func heightValueDidChange(to height: Double) {
        delegate?.heightValueDidChange(to: height)
    }
    
    func weightValueDidChange(to weight: Double) {
        delegate?.weightValueDidChange(to: weight)
    }
    
    func weightGoalDidChange(to goal: WeightGoal) {
        delegate?.weightGoalDidChange(to: goal)
    }
    
    func birthdayFieldSelected() {
        delegate?.birthdayFieldSelected()
    }
    
    func activityLevelDidChange(to level: ActivityLevel) {
        delegate?.activityLevelDidChange(to: level)
    }
}
