//
//  Extensions.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-12.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import UIKit
import CoreData

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
    
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}

extension Serving {
    func getServingSizeText() -> String {
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
    
    func setupNavigationBar(title: String?, barColor: UIColor, titleColor: UIColor) {
        self.navigationItem.title = title
        navigationController?.navigationBar.barTintColor = barColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = titleColor
    }
}

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

extension Float {
    //Clean string without decimal if format is .0
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var toOneDecimalString: String {
        return String (format: "%.1f", self)
    }
}

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
}
