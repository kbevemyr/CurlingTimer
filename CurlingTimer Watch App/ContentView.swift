//
//  ContentView.swift
//  CurlingTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    @State var log:[LogItem] = []
    @State var clock:Clock = Clock(timing: .tee)
    
    var body: some View {
        TabView {
            NavigationStack {
                ClockView(log: $log, clock: $clock)
            }
            NavigationStack {
                LogView(log: $log)
            }
            NavigationStack {
                SettingView(clock: $clock, log: $log)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    ContentView()
}
