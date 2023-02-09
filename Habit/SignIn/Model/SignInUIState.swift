//
//  SignInUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation

enum SignInUIState: Equatable {

    case none //estado ocioso
    case loading
    case goToHomeScreen
    case error(String)
    
}
