//
//  SplashViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading

    public func onAppear() {
        //algo assíncrono e muda o estado da uiState
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //chamado depois de 2segundos
            
//            self.uiState = .error("Erro no servidor")
            self.uiState = .goToSignInScreen
        }
    }
}

extension SplashViewModel {
    public func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
        
    }
}
