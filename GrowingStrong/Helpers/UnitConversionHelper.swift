//
//  UnitConversionHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-04-15.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

class UnitConversionHelper {
    static func centimetersToFeetInches(_ value: Double) -> String {
        if value < 0 {
            return ""
        }
        
        let measureFormatter = MeasurementFormatter()
        measureFormatter.unitOptions = .providedUnit
        measureFormatter.unitStyle = .medium
        
        let numFormatter = NumberFormatter()
        numFormatter.maximumFractionDigits = 0
        measureFormatter.numberFormatter = numFormatter
        
        let feet = Measurement(value: value, unit: UnitLength.centimeters).converted(to: .feet)
        let feetValueRounded = feet.value.rounded(.towardZero)
        let feetRounded = Measurement(value: feetValueRounded, unit: UnitLength.feet)
        let inches = Measurement(value: feet.value - feetValueRounded, unit: UnitLength.feet).converted(to: .inches)
        let inchesValueRounded = inches.value.rounded(.towardZero)
        let inchesRounded = Measurement(value: inchesValueRounded, unit: UnitLength.inches)
        
        return ("\(measureFormatter.string(from: feetRounded)) \(measureFormatter.string(from: inchesRounded))")
    }
    
    static func kilogramsToPounds(_ value: Double) -> Double {
        let pounds = Measurement(value: value, unit: UnitMass.kilograms).converted(to: .pounds)
        return pounds.value
    }
    
    static func kcalToGrams(kcal: Float, kcalPerGram: Float) -> Float {
        return kcal/kcalPerGram
    }
}

