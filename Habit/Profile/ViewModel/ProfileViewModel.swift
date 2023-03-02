//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    //to show on ProfileView
    var userId: Int? //Not @Published - won`t be shown on screen
    @Published var email: String = "teste@gmail.com"
    @Published var document: String = "111.222.333-11"
    @Published var gender: Gender?

    //State
    @Published var uiState: ProfileUIState = .none
    
    //Validation
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    //Cancellables - fetch
    private var cancellableFetchUser: AnyCancellable?
    //Cancellables - update
    private var cancellableUpdateUser: AnyCancellable?
    
    //Interactor
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
        fetchUser()
    }
    
    deinit {
        cancellableFetchUser?.cancel()
        cancellableUpdateUser?.cancel()
    }
    
    public func fetchUser() {
        self.uiState = .loading
        
        cancellableFetchUser = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.uiState = .fetchError(error.message)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.userId = response.id
                self?.email = response.email
                self?.document = response.document
                self?.gender = Gender.allCases[response.gender]
                self?.fullNameValidation.value = response.fullName
                self?.phoneValidation.value = response.phone
                
                self?.uiState = .fetchSuccess
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                //Validar a Data
                guard let dateFormatted = dateFormatted else {
                    self?.uiState = .fetchError("Data inválida \(response.birthday)")
                    return
                }
                
                //Date -> String
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                self?.birthdayValidation.value = birthday
            })
    }
    
    public func updateUser() {
        self.uiState = .updateLoading
        
        //Id e Gender
        guard let userId = userId,
              let gender = gender else { return }
        
        //Birthday
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthdayValidation.value)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .updateError("Data inválida \(birthdayValidation.value)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
//        self.birthdayValidation.value = birthday
        
        cancellableUpdateUser = interactor.updateUser(userId: userId, profileRequest:
                                ProfileUpdateRequest(
                                    fullName: fullNameValidation.value,
                                    phone: phoneValidation.value,
                                    birthday: birthday,
                                    gender: gender.index))
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.uiState = .fetchError(error.message)
            case .finished:
                break
            }
        } receiveValue: { [weak self] response in
            self?.uiState = .updateSuccess
        }
    }
}

extension ProfileViewModel {
    
    func isDisabled() -> Bool {
        if fullNameValidation.failure
            || phoneValidation.failure
        || birthdayValidation.failure {
            return false
        } else {
            return true
        }
    }
}

class FullNameValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 3 && value.count > 0
        }
    }
}

class PhoneValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = (value.count < 10 || value.count >= 12) && value.count > 0
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure: Bool = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10 && value.count > 0
        }
    }
}
