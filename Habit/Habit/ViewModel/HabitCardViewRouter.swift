//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Combine
import SwiftUI

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id: Int, name: String, label: String,
                                    habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(vm: viewModel)
    }
    
    static func makeChartView(id: Int) -> some View {
        let viewModel = ChartViewModel(habitId: id, interactor: ChartInteractor())
        return ChartView(vm: viewModel)
    }
}
