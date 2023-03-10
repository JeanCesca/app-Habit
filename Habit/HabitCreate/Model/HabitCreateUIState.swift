//
//  HabitCreateUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import Foundation

enum HabitCreateUIState: Equatable {

    case none //estado ocioso
    case loading
    case success
    case error(String)
    
}
