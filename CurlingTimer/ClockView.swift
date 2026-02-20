//
//  ClockView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-02.
//


import SwiftUI

struct ClockView: View {
    @State private var isRunning: Bool = false
 
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    @Binding var log: Log
    @Binding var clock: Clock
    
    let thickness: CGFloat = 30
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let radius = size / 2
            
            ZStack {
                Circle()
                    .fill(Color.neutral)
                Circle()
                    .stroke(getClockColor(), lineWidth: thickness)
                VStack {
                    Spacer()
                    Text(getClockTime())
                        .font(.system(size: size * 0.28, weight: .bold, design: .default))
                        .onReceive(timer) { _ in
                            clock.updateTime()
                        }
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
                    text: getClockLabel(),
                    radius: radius * 0.97,                // relative to circle size
                    startAngle: .degrees(-150),
                    endAngle: .degrees(-105),
                    font: .system(size: size * 0.13, weight: .bold, design: .default),
                    color: getClockColor()
                )
            }
            .contentShape(Circle())
            .onTapGesture {
                if self.isRunning {
                    clock.stopTime()
                    let clockedtime = clock.getTime()
                    let newPost = LogItem(id: log.postcounter, when: clock.now, bakkant: clockedtime.back, tee: clockedtime.tee, hoghog: clockedtime.hoghog)
                    log.addPost(post: newPost)
                    self.isRunning.toggle()
                } else {
                    self.isRunning.toggle()
                    clock.initTime()
                }
            }
            .sensoryFeedback(.start, trigger: isRunning)
        }
        .aspectRatio(1, contentMode: .fit) // keeps it a circle
    }

    func timeString(time: Double) -> String {
        let time = String(format: "%.2f", time/1000)
        return time
    }
    
    private func getClockLabel() -> String {
        if self.isRunning {
            return "STOP"
        } else {
            return "START"
        }
    }
    
    private func getClockTime() -> AttributedString {
        if clock.presentation == .one {
            getClockTime1()
        } else {
            getClockTime2()
        }
    }

    private func getClockTime1() -> AttributedString {
        var ret: AttributedString = ""
        
        if self.isRunning {
            ret = try! AttributedString(markdown:"\(timeString(time: Double(clock.currentTime)))")
        } else {
            if clock.t_end != 0 {
                if clock.timingLine == .tee {
                    ret = try! AttributedString(markdown:"**\(timeString(time: Double(clock.t_end)))**")
                } else {
                    ret = try! AttributedString(markdown:"**\(timeString(time: Double(clock.t_end)))**")
                }
            }
        }
        return ret
    }
    
    private func getClockTime2() -> AttributedString {
        var ret: AttributedString = ""
        
        if self.isRunning {
            ret = try! AttributedString(markdown:"\(timeString(time: Double(clock.currentTime)))")
        } else {
            if clock.t_end != 0 {
                if clock.timingLine == .tee {
                    //try! AttributedString(markdown:
                    ret = try! AttributedString(markdown: "**Tee: \(timeString(time: Double(clock.t_end)))** \nBack: \(timeString(time: clock.calcBackTime(tee: Double(clock.t_end))))")
                } else {
                    ret = try! AttributedString(markdown: "Tee: \(timeString(time: clock.calcTeeTime(back: Double(clock.t_end))))\n **Back: \(timeString(time: Double(clock.t_end)))**")
                }
            }
        }
        return ret
    }
    
    private func getClockColor() -> Color {
        if self.isRunning {
            return Color(UIColor(named: "StopColor")!)
        } else {
            return Color(UIColor(named: "StartColor")!)
        }
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
            return ClockView(log: .constant(samplelog),clock: .constant(sampleclock))
        }
    }
}
