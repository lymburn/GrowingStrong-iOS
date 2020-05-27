//
//  BaseOptionsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

class BaseOptionsLauncher: NSObject {
    override init() {
        super.init()
        
    }
    
    private var withDim: Bool!
    let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
    let blackView = UIView()
    
    func launchOptions(withDim: Bool) {
        self.withDim = withDim
        
        if withDim {
            displayDimView()
        }
    }
    
    private func displayDimView() {
        if let window = window {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptions)))
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
            }, completion: nil)
        }
    }
    
    private func dismissDimView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
        })
    }
    
    @objc func dismissOptions() {
        if withDim {
            dismissDimView()
        }
    }
}
