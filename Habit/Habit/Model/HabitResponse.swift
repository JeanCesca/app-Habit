//
//  HabitResponse.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation

struct HabitResponse: Codable {
    let id: Int
    let name: String
    let label: String
    let iconUrl: String?
    let value: Int?
    let lastDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, label, value
        case iconUrl = "icon_url"
        case lastDate = "last_date"
    }
}
