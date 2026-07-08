//
//  ClockView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-02.
//


import SwiftUI

struct ClockView: View {
    @State private var isRunning: Bool = false
    @State private var ticker: Timer?

    @Binding var log: Log
    var clock: Clock
    
    let thickness: CGFloat = 30
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let radius = size / 2
            
            ZStack {
                Circle()
                    .fill(Color.neutral)
                Circle()
                    .stroke(clockColor, lineWidth: thickness)
                VStack {
                    Spacer()
                    Text(clockTime)
                        .font(.system(size: size * 0.28, weight: .bold, design: .default))
                    Spacer()
                }

                // Curved text background
                Circle()
                    .trim(from: 0.81, to: 0.98)
                    .stroke(
                        Color.neutral,
                        style: StrokeStyle(lineWidth: thickness + 2, lineCap: .butt)
                    )
                    .rotationEffect(.degrees(-90))

                // Curved text
                CurvedText(
                    text: clockLabel,
                    radius: radius * 0.97,                // relative to circle size
                    startAngle: .degrees(-150),
                    endAngle: .degrees(-105),
                    font: .system(size: size * 0.13, weight: .bold, design: .default),
                    color: clockColor
                )
            }
            .contentShape(Circle())
            .onTapGesture {
                toggleTimer()
            }
            .sensoryFeedback(trigger: isRunning) { _, isNowRunning in
                isNowRunning ? .start : .success
            }
        }
        .aspectRatio(1, contentMode: .fit) // keeps it a circle
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
        // .common keeps the display updating while the log is being scrolled.
        RunLoop.main.add(timer, forMode: .common)
        ticker = timer
    }

    private func stopTicker() {
        ticker?.invalidate()
        ticker = nil
    }

    // MARK: - Display

    private var clockLabel: String {
        isRunning ? "STOP" : "START"
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
    
    struct CurvedText: View {
        let text: String
        let radius: CGFloat
        let startAngle: Angle
        let endAngle: Angle
        let font: Font
        let color: Color

        var body: some View {
            let chars = Array(text)
            let count = max(chars.count, 1)
            let total = endAngle.degrees - startAngle.degrees
            let step = count > 1 ? total / Double(count - 1) : 0

            ZStack {
                ForEach(chars.indices, id: \.self) { i in
                    let angle = startAngle.degrees + (Double(i) * step)

                    Text(String(chars[i]))
                        .font(font)
                        .foregroundStyle(color)
                    
                        // 👇 THIS hides the ring behind letters
                        .padding(1)
                        // Move letter out from center
                        .offset(x: 0, y: -radius)
                        // Rotate letter around center to arc position
                        .rotationEffect(.degrees(angle))
                        // Optional: tilt glyph to follow tangent (usually looks better)
                        .rotationEffect(.degrees(90), anchor: .center)
                }
            }
            .backgroundStyle(Color.primaryBackground)
        }
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
