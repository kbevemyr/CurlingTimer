//
//  LogView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

import SwiftUI

struct LogView: View {
    @Binding var log: Log
    @Binding var clock: Clock
    
    var body: some View {
        VStack {
            HStack {
                Text("\(clock.timingLine.stringValue())").foregroundColor(Color.secondaryBackground)
                    //.opacity(clock.presentation == .one ?  0 : 1)
                Spacer()
                Button("Clear log") {
                    log.clearLog()
                    clock.initTime()
                }.foregroundColor(Color.secondaryBackground)
            }
            .padding(.all, 5)
            VStack (spacing: 0) {
                ScrollView {
                    Section (header: LogHeaderView(mode: $clock.timingLine)) {
                        ForEach($log.items.reversed()) {
                            logitem in LogItemView(logitem: logitem, mode: $clock.timingLine)
                        }
                    }
                }
                .padding()
                .mask {
                    LinearGradient(
                        colors: [.black, .black, .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
        }
    }
}

struct LogView_Previews:PreviewProvider {
    static var previews: some View {
        let samplelogItems: [LogItem] =
        [LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3331, hoghog: 9877),
        LogItem(id: 2, when: Date.init(), bakkant: 3238, tee: 4456, hoghog: 7050)]
        var samplelog: Log = Log()
        samplelog.addPost(post: samplelogItems[0])
        samplelog.addPost(post: samplelogItems[1])
        let sampleclock: Clock = Clock()
        return LogView(log: .constant(samplelog), clock: .constant(sampleclock))
    }
}

