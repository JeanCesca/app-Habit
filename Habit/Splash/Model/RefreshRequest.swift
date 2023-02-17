//
//  RefreshRequest.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation

struct RefreshRequest: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
