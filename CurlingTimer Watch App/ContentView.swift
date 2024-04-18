//
//  ContentView.swift
//  CurlingTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    @State var log:Log = Log()
    @State var clock:Clock = Clock()
    
    var body: some View {
        TabView {
            NavigationStack {
                ClockView(log: $log, clock: $clock)
            }.containerBackground(.red.gradient, for: .tabView)
            NavigationStack {
                LogView(log: $log)
            }.containerBackground(.blue.gradient, for: .tabView)
            NavigationStack {
                SettingView(clock: $clock, log: $log)
            }.containerBackground(.blue.gradient, for: .tabView)
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    ContentView()
}
