//
//  SignInUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation

enum SignInUIState {
    
    //none é o estado ocioso
    case none
    case loading
    case goToHomeScreen
    case error(String)
    
}
