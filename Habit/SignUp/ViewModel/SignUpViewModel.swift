//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthday: String = ""
    @Published var gender: Gender = Gender.male
    
    //Combine
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    func signUp() {
        self.uiState = .loading
        
        //Transformar String dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        //Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        //Date -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        WebService.registerUser(request: SignUpRequest(
            fullName: fullName,
            email: email,
            password: password,
            document: document,
            phone: phone,
            birthday: birthday,
            gender: gender.index)) { successResponse, errorResponse in
                
                if let errorResponse = errorResponse {
                    DispatchQueue.main.async {
                        self.uiState = .error(errorResponse.detail)
                    }
                }
                
                if let success = successResponse {
                    
//                    WebService.loginUser(request: SignInRequest(email: self.email, password: self.password)) { successResponse, errorResponse in
//
//                        if let errorSignIn = errorResponse {
//                            DispatchQueue.main.async {
//                                self.uiState = .error(errorSignIn.detail.message)
//                            }
//                        }
//
//                        if let successSignIn = successResponse {
//                            DispatchQueue.main.async {
//                                print(successSignIn)
//                                self.publisher.send(success)
//                                self.uiState = .success
//                            }
//                        }
//
//                    }
                }
            }
    }
}

extension SignUpViewModel {
    
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
