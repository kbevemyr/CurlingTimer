//
//  SettingView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-19.
//

import SwiftUI

struct SettingView: View {
    @Bindable var clock: Clock
    @Binding var log: Log
        
    var body: some View {
        VStack {
            Picker("Timing Strategy", selection: $clock.timingLine) {
                ForEach(Clock.TimerStrategy.allCases, id: \.self) { item in
                    Text("\(item.stringValue())")
                    //.tag(item)
                }
            }.pickerStyle(.navigationLink)
                .onChange(of: clock.timingLine) {
                    // Changing timing strategy invalidates logged times.
                    log.clearLog()
                    clock.initTime()
                }
            Button("Clear log") {
                log.clearLog()
                clock.initTime()
            }
        }
    }
}

#Preview {
    let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33, hoghog: 0),
                                LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33, hoghog: 0)]
    var samplelog: Log = Log()
    samplelog.addPost(post: samplelogItems[0])
    samplelog.addPost(post: samplelogItems[1])
    let sampleclock: Clock = Clock()
    return SettingView(clock: sampleclock, log: .constant(samplelog))
}
