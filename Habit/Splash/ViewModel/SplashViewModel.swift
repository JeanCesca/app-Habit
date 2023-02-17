//
//  SplashViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    //Combine
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    //Interactor
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }

    public func onAppear() {

        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userAuth in
                
                //se userAuth == nil -> Login
                if userAuth == nil {
                    self?.uiState = .goToSignInScreen
                }
                //se user userAuth != nil && expirou -> Token Refresh
                else if userAuth != nil && (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    self?.subscribeRefresh(userAuth: userAuth)
                }
                //senao -> Tela home
                else {
                    self?.uiState = .goToHomeScreen
                }
        }
    }
    
    public func subscribeRefresh(userAuth: UserAuth?) {
        cancellableRefresh = interactor.refreshToken(refreshRequest: RefreshRequest(token: userAuth!.refreshToken))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.uiState = .goToSignInScreen
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] successResponse in
                
                let auth = UserAuth(
                    idToken: successResponse.accessToken,
                    refreshToken: successResponse.refreshToken,
                    expires: Date().timeIntervalSince1970 + Double(successResponse.expires),
                    tokenType: successResponse.tokenType)
                
                self?.interactor.insertAuth(userAuth: auth)
                self?.uiState = .goToHomeScreen
            })
    }
}

extension SplashViewModel {
    public func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
        
    }
}
