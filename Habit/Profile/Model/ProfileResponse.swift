//
//  ProfileResponse.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case id, email, document, phone, birthday, gender
    }
}
