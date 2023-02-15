//
//  SignInRequest.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

struct SignInRequest {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "username"
        case password
    }
}
