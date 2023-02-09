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
