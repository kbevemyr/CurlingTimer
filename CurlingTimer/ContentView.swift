//
//  ContentView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    @State var log:Log = Log()
    @State var clock:Clock = Clock()
    
    var body: some View {
        TabView {
            ClockView(log: $log, clock: $clock)
                .tabItem {
                    Image(systemName: "clock")
                    Text("Clock")
                }
            LogView(log: $log)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Log")
                }
            
            InfoView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            
            SettingView(clock: $clock, log: $log)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    ContentView()
}
