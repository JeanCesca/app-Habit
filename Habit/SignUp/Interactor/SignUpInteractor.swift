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
    private let localDataSource: LocalDataSource = .shared
    
}

extension SignUpInteractor {
    
    public func registerUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.registerUser(request: request)
    }
    
    public func loginUser(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.loginUser(request: request)
    }
    
    public func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
}
