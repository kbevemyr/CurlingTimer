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
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color(UIColor.systemBackground))
                .opacity(0.8)
                .frame(width: 300, height: 300)
                .overlay(
                    Circle()
                        .stroke(getClockColor(), lineWidth: 20)
                        .overlay(
                            VStack {
                                Spacer()
                                Text(getClockLabel()).font(.largeTitle).frame(alignment: .center)
                                //Spacer()
                                Text(getClockTime()).font(.largeTitle)
                                    .onReceive(timer) { _ in
                                        clock.updateTime()
                                    }
                                Spacer()
                            }
                    )
                )
        }
        .contentShape(Circle())
        .onTapGesture {
            // Action to perform when the rectangle is tapped
            if self.isRunning {
                // Start -> Stop
                clock.stopTime()
                let teetime = clock.getTeeTime()
                let backtime = clock.getBackTime()
                let newPost = LogItem(id: log.postcounter, when: clock.now, bakkant: backtime, tee: teetime)
                log.addPost(post: newPost)
                self.isRunning.toggle()
            } else {
                // Stop -> Start
                self.isRunning.toggle()
                clock.initTime()
            }
        }
//        .containerBackground(LinearGradient(gradient: Gradient(colors: [getClockColor(), .black]), startPoint: .top, endPoint: .bottom), for: .tabView)
        .sensoryFeedback(.start, trigger: isRunning)
    }

    func timeString(time: Double) -> String {
        let time = String(format: "%.2f", time/1000)
        return time
    }
    
    private func getClockLabel() -> String {
        if self.isRunning {
            return "Stop"
        } else {
            return "Start"
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
    
    struct ClockView_Previews: PreviewProvider {
        static var previews: some View {
            let samplelogItems: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33),
                                        LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33)]
            var samplelog: Log = Log()
            samplelog.addPost(post: samplelogItems[0])
            samplelog.addPost(post: samplelogItems[1])
            let sampleclock: Clock = Clock()
            return ClockView(log: .constant(samplelog),clock: .constant(sampleclock))
        }
    }
}
