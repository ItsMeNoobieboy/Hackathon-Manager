//
//  Event.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/14/24.
//

import Foundation

struct Event: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var startTime: Date
    var endTime: Date
}
