//
//  LogView.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import SwiftUI

struct LogView: View {
    @Binding var log: [LogItem]
        
    var body: some View {
        if log.isEmpty {
            Text("No times stored")
        } else {
            VStack {
                List($log.reversed()) { logitem in
                    LogItemView(logitem: logitem)
                }
            }
        }
    }
}

struct LogView_Previews:PreviewProvider {
    static var previews: some View {
        let samplelog: [LogItem] = [LogItem(id: 1, when: Date.init(), bakkant: 2340, tee: 3330),
                                    LogItem(id: 2, when: Date.init(), bakkant: 4340, tee: 4330)]
        return LogView(log: .constant(samplelog))
    }
}
