//
//  ActionOptionsLauncher.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-05-27.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

protocol ActionOptionsLauncherDelegate: class {
    func addFoodButtonPressed()
}

class ActionOptionsLauncher: BaseOptionsLauncher {
    override init() {
        super.init()
    }
    
    weak var delegate: ActionOptionsLauncherDelegate?
    
    lazy var actionOptionsView: ActionOptionsView = {
        let view = ActionOptionsView()
        view.delegate = self
        return view
    }()
    
    override func launchOptions(withDim: Bool) {
        super.launchOptions(withDim: withDim)
        displayActionOptionsView()
    }
    
    override func dismissOptions() {
        super.dismissOptions()
        dismissActionOptionsView()
    }
    
    private func displayActionOptionsView() {
        if let window = window {
            let height: CGFloat = SizeConstants.screenSize.height * 0.3
            let y = window.frame.height - height
            
            window.addSubview(actionOptionsView)
            
            actionOptionsView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.actionOptionsView.frame = CGRect(x: 0, y: y, width: self.actionOptionsView.frame.width, height: self.actionOptionsView.frame.height)
                
            }, completion: nil)
        }
    }
    
    private func dismissActionOptionsView() {
        UIView.animate(withDuration: 0.5, animations: {
             if let window = self.window {
                 self.actionOptionsView.frame = CGRect(x: 0, y: window.frame.height, width: self.actionOptionsView.frame.width, height: self.actionOptionsView.frame.height)
             }
         })
    }
}

extension ActionOptionsLauncher: ActionOptionsViewDelegate {
    func addFoodButtonPressed() {
        delegate?.addFoodButtonPressed()
    }
}
