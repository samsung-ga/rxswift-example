//
//  Task.swift
//  GoodList
//
//  Created by Wody on 2022/01/30.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
