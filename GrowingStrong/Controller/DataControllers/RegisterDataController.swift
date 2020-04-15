//
//  RegisterDataSourceProvider.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol RegisterDataControllerDelegate: class {
    func ageValueDidChange(to age: Int)
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit)
    func weightValueDidChange(to weightInKg: Double, unit: MeasurementUnit)
    func measurementUnitDidChange(to unit: MeasurementUnit)
}

class RegisterDataController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let registerStatsCellId: String
    weak var delegate: RegisterDataControllerDelegate?
    
    init(registerStatsCellId: String) {
        self.registerStatsCellId = registerStatsCellId
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let registerStatsCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerStatsCellId, for: indexPath) as! RegisterStatsCell
            registerStatsCell.delegate = self
            return registerStatsCell
        } else {
            let registerStatsCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerStatsCellId, for: indexPath) as! RegisterStatsCell
            return registerStatsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension RegisterDataController: RegisterStatsCellDelegate {
    func measurementUnitDidChange(to unit: MeasurementUnit) {
        delegate?.measurementUnitDidChange(to: unit)
    }
    
    func ageValueDidChange(to age: Int) {
        delegate?.ageValueDidChange(to: age)
    }
    
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit) {
        delegate?.heightValueDidChange(to: heightInCm, unit: unit)
    }
    
    func weightValueDidChange(to weightInKg: Double, unit: MeasurementUnit) {
        delegate?.weightValueDidChange(to: weightInKg, unit: unit)
    }
}
