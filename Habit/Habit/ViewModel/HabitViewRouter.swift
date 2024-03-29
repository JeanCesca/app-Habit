//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import Combine
import SwiftUI

enum HabitViewRouter {
    
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(vm: viewModel)
    }
}
