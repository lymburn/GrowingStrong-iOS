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
        let dataController = RegisterDataController(registerStatsCellId: registerStatsCellId, dateFormatter: dateFormatter)
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
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.date = Date()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        return df
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

//MARK: Helpers
extension RegisterController {
    fileprivate func changeMeasurementUnit(to unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        let heightInCm: Double = Double(cell.heightSlider.value)
        let weightInKg: Double = Double(cell.weightSlider.value)
        
        setRegisterStatsHeightLabel(heightInCm: heightInCm, unit: unit)
        setRegisterStatsWeightLabel(weightInKg: weightInKg, unit: unit)
    }
    
    fileprivate func setRegisterStatsHeightLabel(heightInCm: Double, unit: MeasurementUnit) {
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
    
    fileprivate func setRegisterStatsWeightLabel(weightInKg: Double, unit: MeasurementUnit) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        if unit == .imperial {
            let imperialWeight: Double = MeasurementUnitHelper.kilogramsToPounds(weightInKg)
            let weightRounded = Int(imperialWeight.rounded())
            let imperialWeightString = "Weight: \(weightRounded) lbs"
            cell.weightLabel.colorString(text: imperialWeightString, coloredText: "\(weightRounded) lbs", color: .green)
        } else {
            let metricWeight = Int(weightInKg.rounded())
            let metricWeightString = "Weight: \(metricWeight) kg"
            cell.weightLabel.colorString(text: metricWeightString, coloredText: "\(metricWeight) kg", color: .green)
        }
    }
    
    fileprivate func setRegisterStatsWeightGoalLabel(for goal: WeightGoal) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.goalLabel.colorString(text: "I want to \(goal.rawValue.lowercased()) weight", coloredText: goal.rawValue.lowercased(), color: .green)
    }
    
    fileprivate func setRegisterStatsActivityLevelLabel(for level: ActivityLevel) {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.activityLevelLabel.colorString(text: "My activity level is \(level.rawValue.lowercased())", coloredText: level.rawValue.lowercased(), color: .green)
    }
}

//MARK: Events
extension RegisterController {
    @objc func dateValueChanged() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
}

//MARK: Register data controller delegate
extension RegisterController : RegisterDataControllerDelegate {
    func measurementUnitDidChange(to unit: MeasurementUnit) {
        changeMeasurementUnit(to: unit)
    }
    
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit) {
        setRegisterStatsHeightLabel(heightInCm: heightInCm, unit: unit)
    }
    
    func weightValueDidChange(to weightInKg: Double, unit: MeasurementUnit) {
        setRegisterStatsWeightLabel(weightInKg: weightInKg, unit: unit)
    }
    
    func weightGoalDidChange(to goal: WeightGoal) {
        setRegisterStatsWeightGoalLabel(for: goal)
    }
    
    func birthdayFieldSelected() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! RegisterStatsCell
        
        cell.birthdayTextField.inputView = UIView()
        cell.birthdayTextField.inputAccessoryView = datePicker
        cell.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func activityLevelDidChange(to level: ActivityLevel) {
        setRegisterStatsActivityLevelLabel(for: level)
    }
}
