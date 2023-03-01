//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    let habitViewModel = HabitViewModel(interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel()
}

extension HomeViewModel {
    
    public func habitView() -> some View {
        return HomeViewRouter.makeHabitView(habitViewModel: habitViewModel)
    }
    
    public func profileView() -> some View {
        return HomeViewRouter.makeProfileView(profileViewModel: profileViewModel)
    }
}
