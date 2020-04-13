//
//  Extensions.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit

extension UILabel {
    func colorString(text: String, coloredText: String, color: UIColor) {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: coloredText)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        
        self.attributedText = attributedString
    }
}
