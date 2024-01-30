//
//  ContentView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
        .frame(width: 5, height: 4)
        
        VStack {
            Text("Curling Timer Description").font(.title)
            Text("""
Used to time a stone after it has been set.\n
Timing Strategy is a setting for which line to start the time from, Tee or Back.\n
The time that is not clocked is calculated, therefore you get time for both Tee and Back.\n
All times are logged.\n
The log is reset when restarting the app and when the user chooses to do so.
"""
            ).padding()
        }
        .background()
        .padding()
    }
}

#Preview {
    ContentView()
}
