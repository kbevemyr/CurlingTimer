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

struct Log {
    var postcounter:Int
    var items: [LogItem]
    
    init() {
        items = []
        postcounter = 0
    }
    
    public mutating func clearLog() {
        items = []
        postcounter = 0
    }
    
    public mutating func addPost(post: LogItem) {
        items.append(post)
        postcounter += 1
    }
    
}

