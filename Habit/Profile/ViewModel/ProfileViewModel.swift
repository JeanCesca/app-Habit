//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import Foundation
import SwiftUI


class ProfileViewModel: ObservableObject {
    
//    @Published var fullName: String = ""
    @Published var email: String = "teste@gmail.com"
    @Published var document: String = "111.222.333-11"
//    @Published var phone: String = "(11) 9 9393-8998"
//    @Published var birthday: String = "03/10/1992"
//
    @Published var selectedGender: Gender? = .cisMale
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()

}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}
