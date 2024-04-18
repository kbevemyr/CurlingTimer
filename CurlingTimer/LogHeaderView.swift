//
//  LogHeaderView.swift
//  CurlingTimer
//
//  Created by Katrin Boberg Bevemyr on 2024-04-14.
//

import SwiftUI

struct LogHeaderView: View {
    var body: some View {
        HStack {
            Text("Date")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text("Tee")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text("Back")
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding()
    }
}

#Preview {
    LogHeaderView()
}
