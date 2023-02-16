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
    @Published var testeToken = ""
    
    //Combine
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private var cancellableTest: AnyCancellable?

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
    
    public func testeRequest() {
        cancellableTest = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                self.testeToken = userAuth?.idToken ?? "Token ainda não registrado"
            }
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
                    expires: successResponse.expires,
                    tokenType: successResponse.tokenType)
                
                self?.interactor.insertAuth(userAuth: auth)
                self?.uiState = .goToHomeScreen
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
