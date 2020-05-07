//
//  DateBar.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol DateBarProtocol {
    func getDateValue() -> String
    func setDateValue(text: String?)
}

protocol DateBarDelegate: class {
    func previousDatePressed()
    func nextDatePressed()
}

class DateBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: DateBarDelegate? = nil
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    let previousMonth: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNames.UtilityButton.leftArrow), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousDatePressed), for: .touchDown)
        return button
    }()
    
    let nextMonth: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNames.UtilityButton.rightArrow), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextDatePressed), for: .touchDown)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension DateBar {
    fileprivate func setupViews() {
        backgroundColor = .green
        addSubview(dateLabel)
        addSubview(previousMonth)
        addSubview(nextMonth)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        previousMonth.widthAnchor.constraint(equalToConstant: 22).isActive = true
        previousMonth.heightAnchor.constraint(equalToConstant: 22).isActive = true
        previousMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        previousMonth.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8).isActive = true

        nextMonth.widthAnchor.constraint(equalToConstant: 22).isActive = true
        nextMonth.heightAnchor.constraint(equalToConstant: 22).isActive = true
        nextMonth.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nextMonth.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8).isActive = true
        
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
}

//MARK: Touch events
extension DateBar {
    @objc func previousDatePressed() {
        delegate?.previousDatePressed()
    }
    
    @objc func nextDatePressed() {
        delegate?.nextDatePressed()
    }
}

//MARK: DateBarProtocol Implementation
extension DateBar: DateBarProtocol {
    func getDateValue() -> String {
        return dateLabel.text ?? ""
    }
    
    func setDateValue(text: String?) {
        dateLabel.text = text
    }
}
