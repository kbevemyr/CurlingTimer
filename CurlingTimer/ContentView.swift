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
    @State private var showingSettings = false
    @State private var showingInfo = false
    
    var body: some View {
        VStack {
            NavigationStack {
                LogView(log: $log, clock: $clock)
                .padding(.all, 10)
                ClockView(log: $log, clock: $clock)
                .padding()
                Spacer()
                .navigationTitle("Curling Timer")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Info") {
                                showingInfo = true
                            }
                            . sheet(isPresented: $showingInfo) {
                                InfoView()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                showingSettings = true
                            }) {
                                Image(systemName: "gear")
                            }
                            .fullScreenCover(isPresented: $showingSettings) {
                                SettingView(clock: $clock, log: $log)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
