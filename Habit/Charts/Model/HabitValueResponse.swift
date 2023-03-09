//
//  HabitValueResponse.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/03/23.
//

import Foundation

/*
 {
   "id": 385,
   "value": 111,
   "created_date": "2023-02-28T19:25:21",
   "habit_id": 229
 },
 */

struct HabitValueResponse: Decodable {
    let id: Int
    let value: Int
    let createdDate: String
    let habitId: Int
    
    enum CodingKeys: String, CodingKey {
        case id, value
        case createdDate = "created_date"
        case habitId = "habit_id"
    }
}
