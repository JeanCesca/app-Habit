//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    
    
}

extension HomeViewModel {
    
    public func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
