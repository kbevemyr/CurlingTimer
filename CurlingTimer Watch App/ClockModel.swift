//
//  ClockModel.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import Foundation

struct Clock {
    
    enum TimerStrategi: Int, CaseIterable {
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
    
    public var timeing: TimerStrategi
}


