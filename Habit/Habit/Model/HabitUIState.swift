//
//  HabitUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Foundation

enum HabitUIState: Equatable {
    
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
