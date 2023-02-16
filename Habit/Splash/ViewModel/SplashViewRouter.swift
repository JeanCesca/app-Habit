//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        return SignInView(vm: SignInViewModel(interactor: SignInInteractor()))
    }
}
