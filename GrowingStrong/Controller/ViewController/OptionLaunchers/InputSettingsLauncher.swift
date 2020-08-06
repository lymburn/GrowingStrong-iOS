//
//  InputSettingsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-08-06.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation
import UIKit

class InputSettingsLauncher: BaseOptionsLauncher {
    override init() {
        super.init()
    }

    lazy var inputView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func launchOptions(withDim: Bool) {
        super.launchOptions(withDim: withDim)
        displayServingSizeOptionsTableView()
    }
    
    private func displayServingSizeOptionsTableView() {
        if let window = window {
            let width: CGFloat = SizeConstants.screenSize.width * 0.8
            let height: CGFloat = SizeConstants.screenSize.height * 0.3
            let x: CGFloat = (window.frame.width - width)/2
            let y: CGFloat = (window.frame.height - height)/2
            
            window.addSubview(inputView)
            
            inputView.frame = CGRect(x: x, y: window.frame.height, width: width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.inputView.frame = CGRect(x: x, y: y, width: self.inputView.frame.width, height: self.inputView.frame.height)
                
            }, completion: nil)
        }
    }
    
    private func dismissServingSizeOptionsTableView() {
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
        dismissServingSizeOptionsTableView()
    }
}
