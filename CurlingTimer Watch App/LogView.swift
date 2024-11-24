//
//  LogView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import SwiftUI

struct LogView: View {
    @Binding var log: Log;
    @Binding var clock: Clock
        
    var body: some View {
        if log.items.isEmpty {
            Text("No times stored")
        } else {
            VStack (spacing: 0) {
                List {
                    Section (header: LogHeaderView(mode: $clock.timingLine)) {
                        ForEach($log.items.reversed()) {
                            logitem in LogItemView(logitem: logitem, mode: $clock.timingLine)
                        }
                    }
                    .headerProminence(.increased)
                }
            }
        }
    }
}

struct LogView_Previews:PreviewProvider {
    static var previews: some View {
        let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33, hoghog: 8.6),
                                         LogItem(id: 2, when: Date.init(), bakkant: 3.34, tee: 4.33, hoghog:9.7)]
        var samplelog: Log = Log()
        samplelog.addPost(post: samplelogItems[0])
        samplelog.addPost(post: samplelogItems[1])
        let sampleclock: Clock = Clock()
        return LogView(log: .constant(samplelog), clock: .constant(sampleclock))
    }
}
