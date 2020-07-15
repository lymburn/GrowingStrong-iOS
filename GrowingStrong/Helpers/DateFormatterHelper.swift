//
//  DateFormatterHelper.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-14.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

struct DateFormatterHelper {
    static func generateDateFormatter(withFormat format: String) -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = format
        return df
    }
}
