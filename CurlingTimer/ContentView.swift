//
//  ContentView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-01-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            //Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            Image(uiImage: UIImage(named: "Logo")!)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            
            VStack {
                Text("Curling Timer Description").font(.title)
                Text("""
Used to time a stone after it has been set. Either from Back to Hog or Tee to Hog.\n
Timing Strategy is a setting for which line to start the time from, Back or Tee.\n
The time that is not clocked is calculated. Therefore you get time for both Back and Tee.\n
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
