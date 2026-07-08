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
    
    var body: some View {
        HStack {
            Text(TimeFormat.timestamp(logitem.when))
                .font(.footnote).padding(.trailing, 10)
            Spacer()
            if ((mode == .tee) || (mode == .back)) {
                Text(TimeFormat.loggedSeconds(logitem.tee)).font(.title3)
                Spacer()
                Text(TimeFormat.loggedSeconds(logitem.bakkant)).font(.title3)
            } else {
                Text(TimeFormat.loggedSeconds(logitem.hoghog)).font(.title3)
            }
        }
    }
}

struct LogItemView_Previews: PreviewProvider {
    static var previews: some View {
        let logitemsample:LogItem = LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330, hoghog: 8.8)
        let mode:Clock.TimerStrategy = .tee
        LogItemView(logitem: .constant(logitemsample), mode: .constant(mode))
    }
}
