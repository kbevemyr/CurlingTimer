//
//  SettingView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

import SwiftUI

struct SettingView: View {
    @Binding var clock: Clock
    @Binding var log: Log
        
    var body: some View {
        VStack {
            Text("Timer Settings").font(.largeTitle)
                .padding()
            .padding()
            VStack {
                Text("Timing Strategy").font(.title2)
                Picker("Timing Strategy", selection: $clock.timingLine) {
                    ForEach(Clock.TimerStrategy.allCases, id: \.self) { item in
                        Text("\(item.stringValue())")
                            .tag(item)
                    }
                }.pickerStyle(.menu)
            }
            .padding()
            VStack {
                Text("Presentation Mode").font(.title2)
                Picker("Presentation Mode", selection: $clock.presentation) {
                    ForEach(Clock.PresentationMode.allCases, id: \.self) { item in
                        Text("\(item.stringValue())")
                            .tag(item)
                    }
                }.pickerStyle(.menu)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33),
                                LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33)]
    var samplelog: Log = Log()
    samplelog.addPost(post: samplelogItems[0])
    samplelog.addPost(post: samplelogItems[1])
    let sampleclock: Clock = Clock()
    return SettingView(clock: .constant(sampleclock), log: .constant(samplelog))
}

