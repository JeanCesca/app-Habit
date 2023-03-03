//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    //construtores das ViewModels
    let habitViewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
    let habitForChartsViewModel = HabitViewModel(isCharts: true, interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    
    public func habitView() -> some View {
        return HomeViewRouter.makeHabitView(habitViewModel: habitViewModel)
    }
    
    public func habitForChartView() -> some View {
        return HomeViewRouter.makeHabitView(habitViewModel: habitForChartsViewModel)
    }
    
    public func profileView() -> some View {
        return HomeViewRouter.makeProfileView(profileViewModel: profileViewModel)
    }
}
