//
//  RegisterStatsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol RegisterStatsCellDelegate : class {
    func heightValueDidChange(to heightInCm: Double, unit: MeasurementUnit)
    func weightValueDidChange(to weightInKg: Double, unit: MeasurementUnit)
    func measurementUnitDidChange(to unit: MeasurementUnit)
    func weightGoalDidChange(to goal: WeightGoal)
    func birthdayFieldSelected()
    func activityLevelDidChange(to level: ActivityLevel)
}

class RegisterStatsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        measurementUnitSelector.addTarget(self, action: #selector(measurementUnitChanged), for: .valueChanged)
        heightSlider.addTarget(self, action: #selector(heightSliderValueChanged), for: .valueChanged)
        weightSlider.addTarget(self, action: #selector(weightSliderValueChanged), for: .valueChanged)
        goalSelector.addTarget(self, action: #selector(goalSelectorValueChanged), for: .valueChanged)
        birthdayTextField.addTarget(self, action: #selector(birthdayFieldSelected), for: .touchDown)
        activityLevelSelector.addTarget(self, action: #selector(activityLevelSelectorValueChanged), for: .valueChanged)
    }
    
    weak var delegate: RegisterStatsCellDelegate?
    
    let measurementUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I use"
        label.textAlignment = .center
        return label
    }()
    
    let measurementUnitSelector: UISegmentedControl = {
        let items = [MeasurementUnit.metric.rawValue, MeasurementUnit.imperial.rawValue]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I am"
        label.textAlignment = .center
        return label
    }()
    
    let genderSelector: UISegmentedControl = {
        let items = [Gender.male.rawValue, Gender.female.rawValue]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "My birthday is"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .green
        textField.textAlignment = .center
        return textField
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.colorString(text: "Height: 165 cm", coloredText: "165 cm", color: .green)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let heightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 210
        slider.minimumValue = 120
        slider.value = 165
        return slider
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.colorString(text: "Weight: 105 kg", coloredText: "105 kg", color: .green)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let weightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 180
        slider.minimumValue = 30
        slider.value = 105
        return slider
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.colorString(text: "I want to maintain weight", coloredText: "maintain", color: .green)
        label.textAlignment = .center
        return label
    }()
    
    let goalSelector: UISegmentedControl = {
        let items = [WeightGoal.gain.rawValue, WeightGoal.maintain.rawValue, WeightGoal.lose.rawValue]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    let activityLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.colorString(text: "My activity level is sedentary", coloredText: "sedentary", color: .green)
        label.textAlignment = .center
        return label
    }()
    
    let activityLevelSelector: UISegmentedControl = {
        let items = [ActivityLevel.sedentary.rawValue, ActivityLevel.light.rawValue, ActivityLevel.moderate.rawValue, ActivityLevel.extreme.rawValue]
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
extension RegisterStatsCell {
    fileprivate func setupViews() {
        addSubview(measurementUnitLabel)
        addSubview(measurementUnitSelector)
        addSubview(genderLabel)
        addSubview(genderSelector)
        addSubview(birthdayLabel)
        addSubview(birthdayTextField)
        addSubview(heightLabel)
        addSubview(heightSlider)
        addSubview(weightLabel)
        addSubview(weightSlider)
        addSubview(goalLabel)
        addSubview(goalSelector)
        addSubview(activityLevelLabel)
        addSubview(activityLevelSelector)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        measurementUnitLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        measurementUnitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        measurementUnitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        measurementUnitLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        measurementUnitSelector.topAnchor.constraint(equalTo: measurementUnitLabel.bottomAnchor, constant: 4).isActive = true
        measurementUnitSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        measurementUnitSelector.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.4).isActive = true

        genderLabel.topAnchor.constraint(equalTo: measurementUnitSelector.bottomAnchor, constant: 24).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        genderSelector.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 4).isActive = true
        genderSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        genderSelector.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.4).isActive = true

        birthdayLabel.topAnchor.constraint(equalTo: genderSelector.bottomAnchor, constant: 24).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 4).isActive = true
        birthdayTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        birthdayTextField.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.4).isActive = true
        
        heightLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 24).isActive = true
        heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        heightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        heightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        heightSlider.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 4).isActive = true
        heightSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SizeConstants.ScreenSize.width * 0.1).isActive = true
        heightSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SizeConstants.ScreenSize.width * 0.1).isActive = true
        heightSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        weightLabel.topAnchor.constraint(equalTo: heightSlider.bottomAnchor, constant: 24).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        weightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        weightSlider.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 4).isActive = true
        weightSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SizeConstants.ScreenSize.width * 0.1).isActive = true
        weightSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -SizeConstants.ScreenSize.width * 0.1).isActive = true
        weightSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        goalLabel.topAnchor.constraint(equalTo: weightSlider.bottomAnchor, constant: 24).isActive = true
        goalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        goalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        goalLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        goalSelector.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 4).isActive = true
        goalSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        goalSelector.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.7).isActive = true
        
        activityLevelLabel.topAnchor.constraint(equalTo: goalSelector.bottomAnchor, constant: 24).isActive = true
        activityLevelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        activityLevelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        activityLevelLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        activityLevelSelector.topAnchor.constraint(equalTo: activityLevelLabel.bottomAnchor, constant: 4).isActive = true
        activityLevelSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityLevelSelector.widthAnchor.constraint(equalToConstant: SizeConstants.ScreenSize.width * 0.8).isActive = true
    }
}

//MARK: Events
extension RegisterStatsCell {
    @objc func heightSliderValueChanged() {
        let heightInCm: Double = Double(heightSlider.value)
        let unit: MeasurementUnit = measurementUnitSelector.selectedSegmentIndex == 0 ? .metric : .imperial
        delegate?.heightValueDidChange(to: heightInCm, unit: unit)
    }
    
    @objc func weightSliderValueChanged() {
        let weightInKg: Double = Double(weightSlider.value)
        let unit: MeasurementUnit = measurementUnitSelector.selectedSegmentIndex == 0 ? .metric : .imperial
        delegate?.weightValueDidChange(to: weightInKg, unit: unit)
    }
    
    @objc func measurementUnitChanged() {
        let unit: MeasurementUnit = measurementUnitSelector.selectedSegmentIndex == 0 ? .metric : .imperial
        delegate?.measurementUnitDidChange(to: unit)
    }
    
    @objc func goalSelectorValueChanged() {
        var selectedGoal: WeightGoal
        if goalSelector.selectedSegmentIndex == 0 {
            selectedGoal = WeightGoal.gain
        } else if goalSelector.selectedSegmentIndex == 1 {
            selectedGoal = WeightGoal.maintain
        } else {
            selectedGoal = WeightGoal.lose
        }
        
        delegate?.weightGoalDidChange(to: selectedGoal)
    }
    
    @objc func birthdayFieldSelected() {
        delegate?.birthdayFieldSelected()
    }
    
    @objc func activityLevelSelectorValueChanged() {
        var selectedLevel: ActivityLevel
        if activityLevelSelector.selectedSegmentIndex == 0 {
            selectedLevel = ActivityLevel.sedentary
        } else if activityLevelSelector.selectedSegmentIndex == 1 {
            selectedLevel = ActivityLevel.light
        } else if activityLevelSelector.selectedSegmentIndex == 2 {
            selectedLevel = ActivityLevel.moderate
        } else {
            selectedLevel = ActivityLevel.extreme
        }
        
        delegate?.activityLevelDidChange(to: selectedLevel)
    }
}
