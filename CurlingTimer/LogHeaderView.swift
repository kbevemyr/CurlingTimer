//
//  LogHeaderView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-14.
//


//
//  LogHeaderView.swift
//  CurlingTimer
//

import SwiftUI

struct LogHeaderView: View {
    @Binding var mode: Clock.TimerStrategy

    var body: some View {
        HStack {
            Text("Date")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            if mode == .tee || mode == .back {
                Text("Tee")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Back")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("Hog")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .font(.title3)
    }
}


struct LogHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let mode:Clock.TimerStrategy = .tee
        LogHeaderView(mode: .constant(mode))
    }
}
