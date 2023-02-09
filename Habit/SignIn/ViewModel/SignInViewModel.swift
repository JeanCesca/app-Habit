//
//  SignInViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    //Combine
    private var cancellable: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUIState = .none
    
    init() {
        addSubscribers()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .error("Erro")
        }
    }
    
    func addSubscribers() {
        cancellable = publisher.sink(receiveValue: { value in
            if value {
                self.uiState = .goToHomeScreen
            } else {
                
            }
        })
    }
}

extension SignInViewModel {
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
