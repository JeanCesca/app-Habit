//
//  SignUpRequest.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

struct SignUpRequest: Encodable {
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
//    "name": String,
//    "email": String,
//    "document": String,
//    "phone": String,
//    "gender": Int,
//    "birthday": String,
//    "password": String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email, password, document, phone, birthday, gender
    }
}
