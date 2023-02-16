//
//  SignInInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    // private let local: LocalDataSource

}

extension SignInInteractor {
    
    //O interactor pede pro Remote o que fazer.
    public func loginUser(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.loginUser(request: request)
    }
    
}
