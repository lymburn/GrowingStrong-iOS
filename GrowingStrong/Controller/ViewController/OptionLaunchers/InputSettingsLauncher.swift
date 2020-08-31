//
//  InputSettingsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import UIKit

protocol InputSettingsLauncherDelegate: class {
    func savePressed(with input: Float, for settingName: String)
}

class InputSettingsLauncher: BaseOptionsLauncher {
    override init() {
        super.init()
    }
    
    weak var delegate: InputSettingsLauncherDelegate?

    private lazy var inputView: InputNumberView = {
        let view = InputNumberView()
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    override func launchOptions(withDim: Bool) {
        super.launchOptions(withDim: withDim)
        displayInputView()
    }
    
    private func displayInputView() {
        if let window = window {
            let width: CGFloat = SizeConstants.screenSize.width * 0.8
            let height: CGFloat = SizeConstants.screenSize.height * 0.2
            let x: CGFloat = (window.frame.width - width)/2
            let y: CGFloat = (window.frame.height - height)/2
            
            window.addSubview(inputView)
            
            inputView.frame = CGRect(x: x, y: window.frame.height, width: width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.inputView.frame = CGRect(x: x, y: y, width: self.inputView.frame.width, height: self.inputView.frame.height)
                
            }, completion: nil)
        }
    }
    
    private func dismissInputView() {
        UIView.animate(withDuration: 0.5, animations: {
             if let window = self.window {
                let width: CGFloat = SizeConstants.screenSize.width * 0.8
                let x: CGFloat = (window.frame.width - width)/2
                self.inputView.frame = CGRect(x: x, y: window.frame.height, width: self.inputView.frame.width, height: self.inputView.frame.height)
             }
         })
    }

    @objc override func dismissOptions() {
        super.dismissOptions()
        dismissInputView()
    }
    
    func setInputView(title: String, placeholder: String) {
        inputView.titleLabel.text = title
        inputView.inputTextField.placeholder = placeholder
    }
}

extension InputSettingsLauncher: InputNumberViewDelegate {
    func savePressed(with input: Float) {
        let settingName = inputView.titleLabel.text!
        dismissOptions()
        delegate?.savePressed(with: input, for: settingName)
    }
}
