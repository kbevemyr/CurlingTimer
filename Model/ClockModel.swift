//
//  ClockModel.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import Foundation
import Observation

@Observable
final class Clock {

    enum TimerStrategy: Int, CaseIterable {
        case tee
        case back
        case hoghog

        // Convert to string to display in menus and pickers.
        func stringValue() -> String {
            switch(self) {
            case .tee:
                return "Tee -> Hog"
            case .back:
                return "Back -> Hog"
            case .hoghog:
                return "Hog -> Hog"
            }
        }
    }

    /// Empirically determined ratio between the back-to-hog time and the
    /// tee-to-hog time for the same stone. Defined in one place so that the
    /// two conversions below are exact inverses of each other.
    static let backToTeeTimeRatio: Double = 1.256

    var timingLine: TimerStrategy
    var now: Date
    var t_zero: UInt64
    var t_end: UInt64
    var currentTime: UInt64

    init() {
        timingLine = .tee
        now = Date()
        t_zero = DispatchTime.now().uptimeNanoseconds
        t_end = 0
        currentTime = 0
    }


    func initTime() {
        t_zero = DispatchTime.now().uptimeNanoseconds
        currentTime = 0
        t_end = 0
        now = Date.init()
    }

    func updateTime() {
        // You can use your preferred method to get the current time in milliseconds.
        // Here, we are using DispatchTime to calculate the time difference.
        let currentTimeNanos = DispatchTime.now().uptimeNanoseconds - t_zero
        let currentTimeMillis = currentTimeNanos / 1_000_000
        currentTime = currentTimeMillis
    }

    func stopTime() {
        // Compute the elapsed time from the tap itself rather than reusing
        // currentTime, which only reflects the latest UI timer tick and can
        // lag behind when the main thread is busy.
        let elapsedNanos = DispatchTime.now().uptimeNanoseconds - t_zero
        t_end = elapsedNanos / 1_000_000
        currentTime = t_end
    }

    func calcTeeTime(back: Double) -> Double {
        return back / Clock.backToTeeTimeRatio
    }

    func calcBackTime(tee: Double) -> Double {
        return tee * Clock.backToTeeTimeRatio
    }

    func getTime() -> (tee: Double, back: Double, hoghog: Double) {
        let time = Double(t_end)
        switch(timingLine) {
            case .tee:
                return (time, calcBackTime(tee: time), 0)
            case .back:
                return (calcTeeTime(back: time), time, 0)
            case .hoghog:
                return (0, 0, time)
        }
    }

}
