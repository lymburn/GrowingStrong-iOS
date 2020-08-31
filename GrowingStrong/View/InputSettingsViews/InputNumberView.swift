//
//  InputNumberView.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-11.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import UIKit

protocol InputNumberViewDelegate: class {
    func savePressed(with input: Float)
}

class InputNumberView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: InputNumberViewDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let inputTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "0.0"
        tf.font = .preferredFont(forTextStyle: .body)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchDown)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
extension InputNumberView {
    fileprivate func setupViews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(inputTextField)
        addSubview(saveButton)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        let viewHeight = SizeConstants.screenSize.height * 0.2
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: viewHeight * 0.1).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: viewHeight * 0.1).isActive = true
        
        inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: viewHeight * 0.2).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: viewHeight * 0.2).isActive = true
        
        saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        saveButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: viewHeight * 0.1).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewHeight * 0.05).isActive = true
    }
}

extension InputNumberView {
    @objc func saveButtonPressed() {
        guard var input = inputTextField.text else { return }
        
        if input == "" {
            input = inputTextField.placeholder!
        }
        
        guard let floatInput = Float(input) else { return }
        
        delegate?.savePressed(with: floatInput)
    }
}
