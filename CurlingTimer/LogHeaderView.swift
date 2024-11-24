//
//  LogHeaderView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-14.
//

import SwiftUI

struct LogHeaderView: View {
    @Binding var mode: Clock.TimerStrategy
    
    var body: some View {
        HStack {
            Text("Date")
                .font(.title3)
                .fontWeight(.bold).padding(.trailing,20)
            Spacer()
            if ((mode == .tee) || (mode == .back)) {
                Text("Tee")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 13)
                    //.padding(.trailing, 20)
                Spacer()
                Text("Back")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 13)
                    //.padding(.trailing, 15)
            } else {
            //case .hoghog:
                Text("Hog")
                    .font(.title3)
                    .fontWeight(.bold)
            }

        }
    }
}

struct LogHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let mode:Clock.TimerStrategy = .tee
        LogHeaderView(mode: .constant(mode))
    }
}
