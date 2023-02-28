//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
