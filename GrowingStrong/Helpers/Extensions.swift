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

extension Date {
    func isEqualTo(date: Date, by granularity: Calendar.Component) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let result = calendar.compare(self, to: date, toGranularity: granularity)
        let isSameDay = result == .orderedSame
        return isSameDay
    }
}

extension ServingSize {
    func toText() -> String {
        return "\(self.quantity) \(self.unit)"
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
