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
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            Text("Timer Settings").font(.title)
                .padding()
            //.padding()
            VStack {
                Text("Timing Strategy").font(.title2)
                Picker("Timing Strategy", selection: $clock.timingLine) {
                    ForEach(Clock.TimerStrategy.allCases, id: \.self) { item in
                        Text("\(item.stringValue())")
                            .tag(item)
                    }
                }.pickerStyle(.menu)
                    .onChange(of: clock.timingLine) {
                        if(Clock.TimerStrategy.hoghog == clock.timingLine) {
                            clock.presentation = Clock.PresentationMode.one
                        }
                    }
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
            Button("Close Settings") {
                log.clearLog()
                clock.initTime()
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.bordered)
            .padding()
            Spacer()
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
    return SettingView(clock: .constant(sampleclock), log: .constant(samplelog))
}

