//
//  ContentView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    @State var log: Log = Log()
    @State var clock: Clock = Clock()

    @State private var showingSettings = false
    @State private var showingInfo = false

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
                            
                NavigationStack {
                    VStack(spacing: 0) {
                        
                        if isLandscape {
                            HStack {
                                LogView(log: $log, clock: $clock)
                                    .padding(.all, 2)
                                    .frame(maxHeight: .infinity)  // takes all remaining space
                                
                                ClockView(log: $log, clock: $clock)
                                    .padding(.horizontal, 40)
                            }
                        } else {
                            
                            LogView(log: $log, clock: $clock)
                                .padding(.all, 2)
                                .frame(maxHeight: .infinity)  // takes all remaining space
                            
                            ClockView(log: $log, clock: $clock)
                                .padding(.horizontal, 40)
                        }
                    }
                    .toolbar(.hidden, for: .navigationBar) // hide system nav bar
                    .safeAreaInset(edge: .top) {
                        header
                    }
                    .fullScreenCover(isPresented: $showingSettings) {
                        SettingView(clock: $clock, log: $log)
                    }
                    .fullScreenCover(isPresented: $showingInfo) {
                        InfoView()
                    }
                }
        }
    }

    // MARK: - Custom Header

    private var header: some View {
        HStack(alignment: .center) {
            // Left: logo + 2-line title
            HStack(spacing: 10) {
                Button {
                    showingInfo = true
                } label: {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Curling")
                        .font(.custom("Poppins-Black", size: 24))
                    Text("Timer")
                        .font(.custom("Poppins-Black", size: 24))
                }
            }

            Spacer()

            // Right: gear + "Clear log" stacked
            VStack(alignment: .trailing, spacing: 8) {
                Button {
                    showingSettings = true
                } label: {
                    Image("Wheel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    // MARK: - Actions

    private func clearLog() {
        log.clearLog()
    }
}

#Preview {
    ContentView()
}

