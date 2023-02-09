//
//  SignUpUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
