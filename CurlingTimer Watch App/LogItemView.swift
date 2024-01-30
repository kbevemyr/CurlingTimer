//
//  LogItemView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-02.
//

import SwiftUI

struct LogItemView: View {
    
    @Binding var logitem:LogItem
    
    let blue1 = Color(red: 0/255, green: 50/255, blue:107/255) // 0 50 107
    let blue2 = Color(red: 33/255, green: 124/255, blue:230/255)
    let blue3 = Color(UIColor(named: "LogItemColor")!)
    
    var body: some View {
        HStack {
            Text(dateString(date:logitem.when)).font(.footnote)
            Spacer()
            Text(timeString(time: logitem.tee)).font(.title3)
            Spacer()
            Text(timeString(time: logitem.bakkant)).font(.title3)
        }.listRowBackground(blue3)
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
