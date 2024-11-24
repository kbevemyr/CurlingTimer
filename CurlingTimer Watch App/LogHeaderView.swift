//
//  LogHeaderView.swift
//  CurlingTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-10-12.
//

import SwiftUI

struct LogHeaderView: View {
    @Binding var mode: Clock.TimerStrategy
    
    var body: some View {
        HStack {
            Text("Date")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            if ((mode == .tee) || (mode == .back)) {
                Text("Tee")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text("Back")
                    .font(.title3)
                    .fontWeight(.bold)
            } else {
            //case .hoghog:
                Text("Hog")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
    
    struct LogHeaderView_Previews: PreviewProvider {
        static var previews: some View {
            let mode:Clock.TimerStrategy = .tee
            LogHeaderView(mode: .constant(mode))
        }
    }
}

