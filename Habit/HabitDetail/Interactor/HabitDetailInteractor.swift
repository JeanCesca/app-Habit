//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Combine
import SwiftUI

class HabitDetailInteractor {
    
    private let remoteDataSource: HabitDetailRemoteDataSource = .shared

}

extension HabitDetailInteractor {
    
    public func saveValue(habitId: Int, habitValue request: HabitValueRequest) -> Future<Bool, AppError> {
        return remoteDataSource.saveValue(habitId: habitId, request: request)
    }
}
