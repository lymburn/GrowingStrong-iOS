//
//  RegisterStatsView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol RegisterStatsCellDelegate : class {
    func ageValueDidChange(age: Int)
}

class RegisterStatsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        ageSlider.addTarget(self, action: #selector(ageSliderValueChanged), for: .valueChanged)
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
        let items = ["Metric", "Imperial"]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I am a"
        label.textAlignment = .center
        return label
    }()
    
    let genderSelector: UISegmentedControl = {
        let items = ["Man", "Woman"]
        let sc = UISegmentedControl(items: items)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.colorString(text: "I am 44 years old", coloredText: "44", color: .green)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let ageSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 70
        slider.minimumValue = 18
        slider.value = 44
        return slider
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.colorString(text: "I am 44 years old", coloredText: "44", color: .green)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let heightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 70
        slider.minimumValue = 18
        slider.value = 44
        return slider
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
        addSubview(ageLabel)
        addSubview(ageSlider)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        measurementUnitLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        measurementUnitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        measurementUnitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        measurementUnitLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        measurementUnitSelector.topAnchor.constraint(equalTo: measurementUnitLabel.bottomAnchor, constant: 4).isActive = true
        measurementUnitSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        measurementUnitSelector.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.4).isActive = true

        genderLabel.topAnchor.constraint(equalTo: measurementUnitSelector.bottomAnchor, constant: 16).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        genderSelector.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 4).isActive = true
        genderSelector.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        genderSelector.widthAnchor.constraint(equalToConstant: Constants.ScreenSize.width * 0.4).isActive = true

        ageLabel.topAnchor.constraint(equalTo: genderSelector.bottomAnchor, constant: 16).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        ageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        ageSlider.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 4).isActive = true
        ageSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ScreenSize.width * 0.1).isActive = true
        ageSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.ScreenSize.width * 0.1).isActive = true
        ageSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

//MARK: Events
extension RegisterStatsCell {
    @objc func ageSliderValueChanged() {
        let age: Int = Int(ageSlider.value)
        delegate?.ageValueDidChange(age: age)
    }
}
