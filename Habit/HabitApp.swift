//
//  HabitApp.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/10/22.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(vm: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
