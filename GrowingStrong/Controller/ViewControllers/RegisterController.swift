//
//  File.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        collectionView.register(RegisterStatsCell.self, forCellWithReuseIdentifier: registerStatsCellId)
    }
    
    let registerStatsCellId = "registerStatsCell"
    
    lazy var dataController: RegisterDataController = {
        let dataController = RegisterDataController(registerStatsCellId: registerStatsCellId)
        dataController.delegate = self
        return dataController
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = dataController
        cv.delegate = dataController
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
}

//MARK: Setup
extension RegisterController {
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension RegisterController : RegisterDataControllerDelegate {
    func measurementUnitDidChange(to unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        let heightCentimeters: Double = Double(cell.heightSlider.value)
        
        if unit == .imperial {
            let feetInches: String = MeasurementUnitHelper.centimetersToFeetInches(heightCentimeters)
            let imperialHeightString = "Height: \(feetInches)"
            cell.heightLabel.colorString(text: imperialHeightString, coloredText: feetInches, color: .green)
        } else {
            let metricHeight = Int(heightCentimeters.rounded())
            let metricHeightString = "Height: \(metricHeight) cm"
            
            cell.heightLabel.colorString(text: metricHeightString, coloredText: "\(metricHeight) cm", color: .green)
        }
    }
    
    func ageValueDidChange(to age: Int) {
        let ageString: String = String(age)
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        let ageLabelString = "I am \(ageString) years old"
        cell.ageLabel.colorString(text: ageLabelString, coloredText: ageString, color: .green)
    }
    
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        if unit == .imperial {
            let feetInches: String = MeasurementUnitHelper.centimetersToFeetInches(heightInCm)
            let imperialHeightString = "Height: \(feetInches)"
            cell.heightLabel.colorString(text: imperialHeightString, coloredText: feetInches, color: .green)
        } else {
            let heightRounded = Int(heightInCm.rounded())
            let metricHeightString = "Height: \(heightRounded) cm"
            cell.heightLabel.colorString(text: metricHeightString, coloredText: "\(heightRounded) cm", color: .green)
        }
    }
}
