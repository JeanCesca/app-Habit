//
//  HabitInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remoteDataSource: HabitRemoteDataSource = .shared
    
}

extension HabitInteractor {
    
    //O interactor pede pro Remote o que fazer.
    public func fetchHabits() -> Future <[HabitResponse], AppError> {
        return remoteDataSource.fetchHabits()
    }
}
