//
//  SignInInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
    // private let local: LocalDataSource

}

extension SignInInteractor {
    
    //O interactor pede pro Remote o que fazer.
    public func loginUser(loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.loginUser(request: request, completion: completion)
    }
    
}
