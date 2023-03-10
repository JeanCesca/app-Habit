//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import Foundation
import Combine

class HabitCreateInteractor {
    
    private let remote: HabitCreateRemoteDataSource = .shared
}

extension HabitCreateInteractor {
    
    public func saveHabits(habitCreate request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.saveHabit(request: request)
    }
}
