//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(habitViewModel: HabitViewModel) -> some View {
        return HabitView(vm: habitViewModel)
    }
    
    static func makeProfileView(profileViewModel: ProfileViewModel) -> some View {
        return ProfileView(vm: profileViewModel)
    }
}
