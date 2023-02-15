//
//  ErrorResponse.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

struct ErrorResponse: Codable {
    let detail: String 
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
