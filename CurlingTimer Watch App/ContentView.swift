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
            }.containerBackground(Color.primaryBackground, for: .tabView)
            NavigationStack {
                LogView(log: $log, clock: $clock)
            }.containerBackground(Color.primaryBackground, for: .tabView)
            NavigationStack {
                SettingView(clock: $clock, log: $log)
            }.containerBackground(Color.primaryBackground, for: .tabView)
        }
        .tabViewStyle(.verticalPage)
    }
}


#Preview {
    ContentView()
}
