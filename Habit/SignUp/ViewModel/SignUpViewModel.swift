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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .success
            self.publisher.send(true)
        }
    }
}

extension SignUpViewModel {
    
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
