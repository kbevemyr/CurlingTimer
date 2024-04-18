//
//  ClockModel.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import Foundation
    
struct Clock {
    
    enum TimerStrategy: Int, CaseIterable {
        case tee
        case back
        
        // Convert to string to display in menus and pickers.
        func stringValue() -> String {
            switch(self) {
            case .tee:
                return "Tee -> Hog"
            case .back:
                return "Back -> Hog"
            }
        }
    }
    
    enum PresentationMode: Int, CaseIterable {
        case one
        case both
        
        // Convert to string to display in menus and pickers.
        func stringValue() -> String {
            switch(self) {
            case .one:
                return "Active Time"
            case .both:
                return "Active and Calculated Time"
            }
        }
    }
    
    public var timingLine: TimerStrategy
    public var presentation: PresentationMode
    var now: Date
    var t_zero: UInt64
    var t_end: UInt64
    var currentTime: UInt64
    
    init() {
        timingLine = .tee
        presentation = .one
        now = Date()
        t_zero = DispatchTime.now().uptimeNanoseconds
        t_end = 0
        currentTime = 0
    }
    
    
    mutating func initTime() {
        t_zero = DispatchTime.now().uptimeNanoseconds
        currentTime = 0
        t_end = 0
        now = Date.init()
    }
    
    mutating func updateTime() {
        // You can use your preferred method to get the current time in milliseconds.
        // Here, we are using DispatchTime to calculate the time difference.
        let currentTimeNanos = DispatchTime.now().uptimeNanoseconds - t_zero
        let currentTimeMillis = currentTimeNanos / 1_000_000
        currentTime = currentTimeMillis
    }
    
    mutating func stopTime() {
        t_end = currentTime
    }
    
    /*
     T2 = T1 * 1.256
     T2 = T1 * 0.778
     */
    
    func calcTeeTime(back: Double) -> Double {
        return back * 0.778
    }
    
    func calcBackTime(tee: Double) -> Double {
        return tee * 1.256
    }
    
    func getTeeTime() -> Double {
        let time: Double = Double(Int64(bitPattern: t_end))
        var teetime: Double = 0
        if timingLine == .tee {
            teetime = time
        } else {
            teetime = calcTeeTime(back: time)
        }
        return teetime
    }
    
    func getBackTime() -> Double {
        let time: Double = Double(Int64(bitPattern: t_end))
        var backtime: Double = 0
        if timingLine == .tee {
            backtime = calcBackTime(tee: time)
        } else {
            backtime = time
        }
        return backtime
    }
    
}

