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
    
    //Interactor
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
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
                else if userAuth != nil && (Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires)) {
                //self?.uiState = .goToHomeScreen
                }
                //senao -> Tela home
                else {
                    self?.uiState = .goToHomeScreen
                }
        }
    }
}

extension SplashViewModel {
    public func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
        
    }
}
