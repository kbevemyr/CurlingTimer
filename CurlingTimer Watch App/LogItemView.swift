//
//  LogItemView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-02.
//

import SwiftUI

struct LogItemView: View {
    @Binding var logitem:LogItem
    @Binding var mode: Clock.TimerStrategy
    
    let bgcolor = Color(UIColor(named: "LogItemColor")!)
    
    var body: some View {
        HStack {
            Text(dateString(date:logitem.when))
                .font(.footnote).padding(.trailing, 10)
            Spacer()
            if ((mode == .tee) || (mode == .back)) {
                Text(timeString(time: logitem.tee)).font(.title3)
                Spacer()
                Text(timeString(time: logitem.bakkant)).font(.title3)
            } else {
                Text(timeString(time: logitem.hoghog)).font(.title3)
            }
        }.listRowBackground(bgcolor)
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
    
    func timeString(time: Double) -> String{
        let time = String(format: "%.2f", time/1000)
        return time
    }
}

struct LogItemView_Previews: PreviewProvider {
    static var previews: some View {
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330, hoghog: 8.8)
        let mode:Clock.TimerStrategy = .tee
        LogItemView(logitem: .constant(logitemsample), mode: .constant(mode))
    }
}
