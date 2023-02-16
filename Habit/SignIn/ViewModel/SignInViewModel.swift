//
//  SignInViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    //Combine
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?

    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUIState = .none
    
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        addSubscribers()
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.loginUser(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.uiState = SignInUIState.error(errorResponse.message)
                    break
                }
            } receiveValue: { successResponse in
                print(successResponse)
                self.uiState = .goToHomeScreen
            }
    }


        
//        interactor.loginUser(loginRequest: SignInRequest(email: email, password: password)) { successResponse, errorResponse in
//
//            if let errorResponse = errorResponse {
//                DispatchQueue.main.async {
//                }
//            }
//
//            if let successResponse = successResponse {
//                DispatchQueue.main.async {
//                    print(successResponse)
//                    self.uiState = .goToHomeScreen
//                }
//            }
//
//        }
    
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
