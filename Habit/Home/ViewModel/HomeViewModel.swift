//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    
}

extension HomeViewModel {
    
    public func habitView() -> some View {
        return HomeViewRouter.makeHabitView(habitViewModel: viewModel)
    }
}
