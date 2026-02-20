//
//  LogView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-07.
//
//
//  LogView.swift
//  CurlingTimer
//

import SwiftUI

struct LogView: View {
    @Binding var log: Log
    @Binding var clock: Clock
    @State private var showingClearConfirmation = false

    var body: some View {
        VStack() {
            HStack {
                Text("\(clock.timingLine.stringValue())")
                    .foregroundColor(Color.secondaryBackground)
                Spacer()
                Button("Clear log") {
                    showingClearConfirmation = true
                }
                .foregroundColor(Color.secondaryBackground)
                .alert("Clear log?", isPresented: $showingClearConfirmation) {
                    Button("Clear", role: .destructive) {
                        log.clearLog()
                        clock.initTime()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This will remove all log entries.")
                }
            }
            .padding(.all, 15)
            
            VStack(alignment: .leading, spacing: 0) {
                // Header — outside the scroll so it stays fixed
                LogHeaderView(mode: $clock.timingLine)
                    .padding(.horizontal)
                    .padding(.bottom, 6)
                
                // Scrollable rows with bottom fade
                ZStack(alignment: .bottom) {
                    ScrollView {
                        VStack(spacing: 6) {
                            ForEach($log.items.reversed()) { logitem in
                                LogItemView(logitem: logitem, mode: $clock.timingLine)
                            }
                        }
                        .padding(.horizontal)
                        //.padding(.bottom, 40) // breathing room behind the fade
                    }
                    
                    
                    .mask{
                        // Fade overlay
                        LinearGradient(
                            colors: [.black, .black, .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                    //.frame(height: 60)
                    .allowsHitTesting(false)
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

