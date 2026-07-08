//
//  InfoView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-02.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding()
            VStack {
                Text("Curling Timer Description").font(.title)
                Button("Close") {
                    dismiss()
                }
                Text("""
This app is used to time a stone after it has been set. Either from Back to Hog , Tee to Hog or Hog to Hog.\n
Timing Strategy is a setting for which line to start the time from, Back, Tee or Hog.\n
For the Tee to Hog and Back to Hog timing strategy the time that is not clocked is calculated. Therefore you get time for both Tee and Back.\n
All times are logged. \n
The log is reset when closing the app, the user changes Timing Strategy or when the user chooses to do so.
""").padding()
            }
        }
        .background()
        .padding()
    }
}

#Preview {
    InfoView()
}
