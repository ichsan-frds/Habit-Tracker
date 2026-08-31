//
//  Habit.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 11/03/26.
//

import Foundation
import SwiftData

enum HabitType: String {
    case old      = "Old Habit"
    case new      = "New Habit"
    case finalMix = "Final Mix Habit"
}

// MARK: @Model -> Macro (identifier) for the class so it's data is persisted
@Model
class Habit {
    var name: String
    var logo: String
    var startTime: String
    var endTime: String
    var habitDescription: String
    var isCompleted: Bool = false
    var habitType: String

    init(
        name: String,
        logo: String,
        startTime: String,
        endTime: String,
        habitDescription: String,
        isCompleted: Bool = false,
        habitType: HabitType
    ) {
        self.name = name
        self.logo = logo
        self.startTime = startTime
        self.endTime = endTime
        self.habitDescription = habitDescription
        self.habitType = habitType.rawValue
    }
}
