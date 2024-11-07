//
//  LogItemView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

import SwiftUI

struct LogItemView: View {
    
    @Binding var logitem:LogItem
    @Binding var mode: Clock.TimerStrategy
    
    var body: some View {
        HStack {
            Text(dateString(date:logitem.when))
                .font(.title3).padding(.trailing, 10)
            Spacer()
            if ((mode == .tee) || (mode == .back)) {
                Text(timeString(time: logitem.tee)).font(.title3)
                    //.padding(.trailing,20)
                Spacer()
                Text(timeString(time: logitem.bakkant)).font(.title3)
                    //.padding(.trailing, 15)
            } else {
                Text(timeString(time: logitem.hoghog)).font(.title3)
            }
        }
    }
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }
    
    func dateString(date: Date) -> String {
        let time = dateFormat.string(from: date)
         return time
    }
    
    func timeString(time: Double) -> String {
        if (time < 0.01) {
            return ""
        } else {
            let timeStr = String(format: "%.2f", time/1000)
            return timeStr
        }
    }
}

struct LogItemView_Previews: PreviewProvider {
    static var previews: some View {
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330, hoghog:0)
        let mode:Clock.TimerStrategy = .tee
        LogItemView(logitem: .constant(logitemsample), mode: .constant(mode))
    }
}

