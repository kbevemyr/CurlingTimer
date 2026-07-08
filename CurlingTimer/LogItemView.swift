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
            Text(TimeFormat.timestamp(logitem.when))
                .frame(maxWidth: .infinity, alignment: .leading)

            if mode == .tee || mode == .back {
                Text(TimeFormat.loggedSeconds(logitem.tee))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(TimeFormat.loggedSeconds(logitem.bakkant))
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(TimeFormat.loggedSeconds(logitem.hoghog))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .font(.title3)
    }
}

struct LogItemView_Previews: PreviewProvider {
    static var previews: some View {
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330, hoghog:0)
        let mode:Clock.TimerStrategy = .tee
        LogItemView(logitem: .constant(logitemsample), mode: .constant(mode))
    }
}

