//
//  LogItemModel.swift
//  BevemyrTimer Watch App
//
//  Created by Katrin Boberg Bevemyr on 2023-12-30.
//

import Foundation
  
struct LogItem: Hashable, Codable, Identifiable {
    var id: Int
    var when: Date
    var bakkant: Double
    var tee: Double
}
