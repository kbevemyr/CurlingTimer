//
//  LogHeaderView.swift
//  CurlingTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2024-10-12.
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
