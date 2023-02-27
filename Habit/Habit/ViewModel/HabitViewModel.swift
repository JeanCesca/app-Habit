//
//  HabitViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title: String = "Atenção"
    @Published var headline: String = "Fique ligado!"
    @Published var description: String = "Você está atrasado nos hábitos"
    
    
    
}
