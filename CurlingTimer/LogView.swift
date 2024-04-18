//
//  LogView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//

import SwiftUI

struct LogView: View {
    @Binding var log: Log
    
    let blue3 = Color(UIColor(named: "LogItemColor")!)
    
    var body: some View {
        VStack {
            HStack {
                Text("               ")
                Spacer()
                Text("Log").font(.largeTitle)
                Spacer()
                Button("Clear log") {
                    log.clearLog()
                }
            }
            .padding()
            if log.items.isEmpty {
                Text("No times stored")
                Spacer()
            } else {
                VStack (spacing: 0) {
                    List {
                        Section (header: LogHeaderView()) {
                            ForEach($log.items.reversed()) {
                                logitem in LogItemView(logitem: logitem)
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
            }
        }
    }
}

struct LogView_Previews:PreviewProvider {
    static var previews: some View {
        let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33),
                                    LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33)]
        var samplelog: Log = Log()
        samplelog.addPost(post: samplelogItems[0])
        samplelog.addPost(post: samplelogItems[1])
        return LogView(log: .constant(samplelog))
    }
}

