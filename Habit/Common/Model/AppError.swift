//
//  AppError.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(message: let message):
            return message
        }
    }
}
