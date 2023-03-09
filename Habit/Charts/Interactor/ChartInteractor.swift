//
//  ChartInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/03/23.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let chartRemote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return chartRemote.fetchHabitValues(habitId: habitId)
    }
}
