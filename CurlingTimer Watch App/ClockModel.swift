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
    
    public var timing: TimerStrategy
    
    // Ska dessa vara private??
    public var t_zero: UInt64 = DispatchTime.now().uptimeNanoseconds
    public var t_end: UInt64 = 0
    public var currentTime: UInt64 = 0
    //public var pict:
}


