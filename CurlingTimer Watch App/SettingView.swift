//
//  SettingView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-19.
//

import SwiftUI

struct SettingView: View {
    @Binding var clock: Clock
    @Binding var log: [LogItem]
    //@State var mystrategi: Clock.TimerStrategi = .tee
        
    var body: some View {
        VStack {
            Picker("Timing Strategy", selection: $clock.timing) {
                ForEach(Clock.TimerStrategy.allCases, id: \.self) { item in
                    Text("\(item.stringValue())")
                    //.tag(item)
                }
            }.pickerStyle(.navigationLink)
            Button("Clear log") {
                log = []
            }
        }
    }
}

#Preview {
    let samplelog: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33),
                                LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33)]
    let sampleclock: Clock = Clock(timing: .tee)
    return SettingView(clock: .constant(sampleclock), log: .constant(samplelog))
}
