//
//  ClockView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import SwiftUI

struct ClockView: View {
    @State private var isRunning: Bool = false
    @State private var now: Date = Date()
 
    @State private var t_zero: UInt64 = DispatchTime.now().uptimeNanoseconds
    @State private var t_end: UInt64 = 0
    @State private var currentTime: UInt64 = 0
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    @Binding var log: [LogItem]
    @State private var logpostcounter:Int = 0
    
    @Binding var clock: Clock

    var body: some View {
        VStack {
            Rectangle()
                .fill(getClockColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                VStack {
                    Text(getClockLabel()).font(.title).frame(alignment: .center)
                    Text(getClockTime()).font(.title3)
                        .onReceive(timer) { _ in
                            self.updateTime()
                        }
                }
            )
            //Text(clock.timeing.stringValue()).font(.footnote)
            SettingView(clock: $clock).labelsHidden()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Action to perform when the rectangle is tapped
            if self.isRunning {
                // Stop -> Start
                t_end = currentTime
                let teetime = getTeeTime(line: clock.timeing, time: Double(Int64(bitPattern: t_end)))
                let backtime = getBackTime(line: clock.timeing, time: Double(Int64(bitPattern: t_end)))
                let newPost = LogItem(id: logpostcounter, when: now, bakkant: backtime, tee: teetime)
                log.append(newPost)
                logpostcounter += 1
                self.isRunning.toggle()
            } else {
                // Start -> Stop
                self.isRunning.toggle()
                initTime()
            }
        }
    }

    
    func timeString(time: Double) -> String {
        let time = String(format: "%.2f", time/1000)
        return time
    }
    
    private func initTime() {
        self.t_zero = DispatchTime.now().uptimeNanoseconds
        self.currentTime = 0
        self.t_end = 0
        self.now = Date.init()
    }
    
    private func updateTime() {
        // You can use your preferred method to get the current time in milliseconds.
        // Here, we are using DispatchTime to calculate the time difference.
        let currentTimeNanos = DispatchTime.now().uptimeNanoseconds - t_zero
        let currentTimeMillis = currentTimeNanos / 1_000_000
        self.currentTime = currentTimeMillis
    }
    
    /*
     T2 = T1 * 1.256
     T2 = T1 * 0.778
     */
    
    private func calcTeeTime(back: Double) -> Double {
        return back * 0.778
    }
    
    private func calcBackTime(tee: Double) -> Double {
        return tee * 1.256
    }
    
    private func getTeeTime(line: Clock.TimerStrategi, time: Double) -> Double {
        var teetime: Double = 0
        if line == .tee {
            teetime = time
        } else {
            teetime = calcTeeTime(back: time)
        }
        return teetime
    }
                                           
   private func getBackTime(line: Clock.TimerStrategi, time: Double) -> Double {
       var backtime: Double = 0
       if line == .tee {
           backtime = calcBackTime(tee: time)
       } else {
           backtime = time
       }
       return backtime
   }
    
    private func getClockLabel() -> String {
        if self.isRunning {
            return "Stop"
        } else {
            return "Start"
        }
    }

    private func getClockTime() -> String {
        var ret: String = ""
        
        if self.isRunning {
            ret = "\(currentTime)"
        } else {
            if self.t_end != 0 {
                if clock.timeing == .tee {
                    ret = "Tee: \(timeString(time: Double(t_end)))\nBack: \(timeString(time: calcBackTime(tee: Double(t_end))))"
                } else {
                    ret = "Tee: "+timeString(time: calcTeeTime(back: Double(t_end)))+"\nBack: "+timeString(time: Double(t_end))
                }
            }
        }
        return ret
    }
    
    private func getClockTime2() -> AttributedString {
        var ret: AttributedString = ""
        
        if self.isRunning {
            ret = try! AttributedString(markdown:"\(currentTime)")
        } else {
            if self.t_end != 0 {
                if clock.timeing == .tee {
                    //try! AttributedString(markdown:
                    ret = try! AttributedString(markdown: "**Tee: \(timeString(time: Double(t_end)))** \nBack: \(timeString(time: calcBackTime(tee: Double(t_end))))")
                } else {
                    ret = try! AttributedString(markdown: "Tee: \(timeString(time: calcTeeTime(back: Double(t_end))))\n **Back: \(timeString(time: Double(t_end)))**")
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
            let samplelog: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2.34, tee: 3.33),
                                        LogItem(id: 1, when: Date.init(), bakkant: 3.34, tee: 4.33)]
            let sampleclock: Clock = Clock.init(timeing: .tee)
            return ClockView(log: .constant(samplelog),clock: .constant(sampleclock))
        }
    }
}
