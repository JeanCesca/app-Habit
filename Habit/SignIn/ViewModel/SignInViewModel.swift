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
    
    public func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.loginUser(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self?.uiState = SignInUIState.error(errorResponse.message)
                    break
                }
            } receiveValue: { [weak self] successResponse in
                print(successResponse)
                
                let auth = UserAuth(
                    idToken: successResponse.accessToken,
                    refreshToken: successResponse.refreshToken,
                    expires: Date().timeIntervalSince1970 + Double(successResponse.expires),
                    tokenType: successResponse.tokenType)
                
                self?.interactor.insertAuth(userAuth: auth)
                self?.uiState = .goToHomeScreen
            }
    }
    
    func addSubscribers() {
        cancellable = publisher
            .sink(receiveValue: { value in
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
