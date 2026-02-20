//
//  LogItemView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

//
//  LogItemView.swift
//  CurlingTimer
//

import SwiftUI

struct LogItemView: View {
    @Binding var logitem: LogItem
    @Binding var mode: Clock.TimerStrategy

    var body: some View {
        HStack {
            Text(dateString(date: logitem.when))
                .frame(maxWidth: .infinity, alignment: .leading)

            if mode == .tee || mode == .back {
                Text(timeString(time: logitem.tee))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(timeString(time: logitem.bakkant))
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(timeString(time: logitem.hoghog))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .font(.title3)
    }

    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }

    func dateString(date: Date) -> String {
        dateFormat.string(from: date)
    }

    func timeString(time: Double) -> String {
        guard time >= 0.01 else { return "" }
        return String(format: "%.2f", time / 1000)
    }
}

struct LogItemView_Previews: PreviewProvider {
    static var previews: some View {
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330, hoghog:0)
        let mode:Clock.TimerStrategy = .tee
        LogItemView(logitem: .constant(logitemsample), mode: .constant(mode))
    }
}

