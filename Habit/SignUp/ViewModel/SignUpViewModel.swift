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
    @Published var gender: Gender = Gender.cisMale
    
    //Interactor
    private let interactor: SignUpInteractor
    
    //Combine
    var publisher: PassthroughSubject<Bool, Never>?
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    //State
    @Published var uiState: SignUpUIState = .none
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
    func signUp() {
        self.uiState = .loading

        let signUpRequest = SignUpRequest(
            fullName: fullName,
            email: email,
            password: password,
            document: document,
            phone: phone,
            birthday: formattedData(),
            gender: gender.index)
        
        cancellableSignUp = interactor.registerUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                //
                switch completion {
                case .failure(let erroResponse):
                    self?.uiState = .error(erroResponse.message)
                case .finished:
                    break
                }
            } receiveValue: { successSignUp in
                //se tiver criado usuário
                if successSignUp {
                    self.cancellableSignIn = self.interactor.loginUser(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { [weak self] completion in
                            switch completion {
                            case .finished:
                                break
                            case .failure(let appError):
                                self?.uiState = .error(appError.message)
                            }
                        } receiveValue: { [weak self] successSignIn in
                            
                            let auth = UserAuth(
                                idToken: successSignIn.accessToken,
                                refreshToken: successSignIn.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(successSignIn.expires),
                                tokenType: successSignIn.tokenType)
                            
                            self?.interactor.insertAuth(userAuth: auth)
                            
                            self?.publisher?.send(successSignUp)
                            self?.uiState = .success
                        }
                }
            }
    }
}

extension SignUpViewModel {
    func formattedData() -> String {
        //Transformar String dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        //Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return ""
        }
        
        //Date -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        return birthday
    }
}

extension SignUpViewModel {
    
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
