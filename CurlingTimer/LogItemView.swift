//
//  LogItemView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

import SwiftUI

struct LogItemView: View {
    
    @Binding var logitem:LogItem
    
    let blue3 = Color(UIColor(named: "LogItemColor")!)
    
    var body: some View {
        HStack {
            Text(dateString(date:logitem.when)).font(.title3)
            Spacer()
            Text(timeString(time: logitem.tee)).font(.title3)
            Spacer()
            Text(timeString(time: logitem.bakkant)).font(.title3)
        }
        .padding()
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
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330)
        LogItemView(logitem: .constant(logitemsample))
    }
}

