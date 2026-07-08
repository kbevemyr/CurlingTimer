//
//  ClockView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import SwiftUI

struct ClockView: View {
    @State private var isRunning: Bool = false
    @State private var ticker: Timer?

    @Binding var log: Log
    var clock: Clock
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.clear)
                .opacity(0.8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    VStack {
                        Text(clockLabel).font(.title2).frame(alignment: .center)
                        Spacer()
                        Text(clockTime).font(.system(size: 72, weight: .bold, design: .default))
                        Spacer()
                        Text(clock.timingLine.stringValue()).font(.title3).frame(alignment: .center)
                    }
                )
        }
        .contentShape(Rectangle())
        .onTapGesture {
            toggleTimer()
        }
        .containerBackground(LinearGradient(gradient: Gradient(colors: [clockColor, .black]), startPoint: .top, endPoint: .bottom), for: .tabView)
        .sensoryFeedback(trigger: isRunning) { _, isNowRunning in
            isNowRunning ? .start : .success
        }
        .onAppear {
            if isRunning { startTicker() }
        }
        .onDisappear {
            stopTicker()
        }
    }

    // MARK: - Timer control

    private func toggleTimer() {
        if isRunning {
            clock.stopTime()
            stopTicker()
            let clockedtime = clock.getTime()
            let newPost = LogItem(id: log.postcounter, when: clock.now, bakkant: clockedtime.back, tee: clockedtime.tee, hoghog: clockedtime.hoghog)
            log.addPost(post: newPost)
        } else {
            clock.initTime()
            startTicker()
        }
        isRunning.toggle()
    }

    // The display only shows hundredths of a second, so 50 updates per second
    // is plenty. The measurement itself is taken in Clock.stopTime() and does
    // not depend on this timer.
    private func startTicker() {
        guard ticker == nil else { return }
        let timer = Timer(timeInterval: 0.02, repeats: true) { _ in
            clock.updateTime()
        }
        RunLoop.main.add(timer, forMode: .common)
        ticker = timer
    }

    private func stopTicker() {
        ticker?.invalidate()
        ticker = nil
    }

    // MARK: - Display

    private var clockLabel: String {
        isRunning ? "Stop" : "Start"
    }

    private var clockTime: String {
        if isRunning {
            return TimeFormat.seconds(Double(clock.currentTime))
        } else if clock.t_end != 0 {
            return TimeFormat.seconds(Double(clock.t_end))
        } else {
            return ""
        }
    }

    private var clockColor: Color {
        isRunning ? Color.stop : Color.start
    }
    
    struct ClockView_Previews: PreviewProvider {
        static var previews: some View {
            let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33, hoghog: 0),
                                        LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33, hoghog: 0)]
            var samplelog: Log = Log()
            samplelog.addPost(post: samplelogItems[0])
            samplelog.addPost(post: samplelogItems[1])
            let sampleclock: Clock = Clock()
            return ClockView(log: .constant(samplelog),clock: sampleclock)
        }
    }
}
