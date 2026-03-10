//
//  Item.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 10/03/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
