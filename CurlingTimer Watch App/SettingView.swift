//
//  SettingView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-19.
//

import SwiftUI

struct SettingView: View {
    @Binding var clock: Clock
    //@State var mystrategi: Clock.TimerStrategi = .tee
        
    var body: some View {
        Picker("Timing Strategi", selection: $clock.timeing) {
                ForEach(Clock.TimerStrategi.allCases, id: \.self) { item in
                    Text("\(item.stringValue())")
                        //.tag(item)
                }
        }.pickerStyle(.navigationLink)
    }
}

#Preview {
    let sampleclock: Clock = Clock(timeing: .tee)
    return SettingView(clock: .constant(sampleclock))
}
