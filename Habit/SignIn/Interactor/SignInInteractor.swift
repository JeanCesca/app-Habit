//
//  SignInInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remoteDataSource: SignInRemoteDataSource = .shared
    private let localDataSource: LocalDataSource = .shared

}

extension SignInInteractor {
    
    public func fetchAuth() -> Future<UserAuth?, Never> {
        return localDataSource.getUserAuth()
    }
    
    //O interactor pede pro Remote o que fazer.
    public func loginUser(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteDataSource.loginUser(request: request)
    }
    
    public func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
    
}
