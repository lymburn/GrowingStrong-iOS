//
//  RepeatingTimer.swift
//  GrowingStrong
//
//  Created by Eugene Lu on 2020-07-22.
//  Copyright © 2020 Eugene Lu. All rights reserved.
//
import Foundation

//DispatchSourceTimer wrapper for handling GCD 
class RepeatingTimer {

    let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        eventHandler = nil
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return t
    }()

    var eventHandler: (() -> Void)?

    private enum State {
        case suspended
        case resumed
    }

    private var state: State = .suspended

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
