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

extension DateFormatter {
    func getCurrentDateString() -> String {
        return self.string(from: Date())
    }
    
    func getPreviousDateString(from dateText: String) -> String? {
        if let date = self.date(from: dateText) {
            if let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date) {
                let previousDateString = self.string(from: previousDate)
                return previousDateString
            }
        }
        
        return nil
    }
    
    func getNextDateString(from dateText: String) -> String? {
        if let date = self.date(from: dateText) {
            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                let nextDateString = self.string(from: nextDate)
                return nextDateString
            }
        }
        
        return nil
    }
}
