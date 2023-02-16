//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    
}

extension SignUpInteractor {
    
    func registerUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.registerUser(request: request)
    }
    
    func loginUser(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.loginUser(request: request)
    }
}
