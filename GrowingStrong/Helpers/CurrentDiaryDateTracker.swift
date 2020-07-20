//
//  CurrentDiaryDateTracker.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-20.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//

import Foundation

class CurrentDiaryDateTracker {
    static let shared = CurrentDiaryDateTracker()
    var currentDate: Date = Date()
}
