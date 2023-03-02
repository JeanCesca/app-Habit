//
//  ProfileUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
