//
//  SpashInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remoteDataSource: SplashRemoteDataSource = .shared
    private let localDataSource: LocalDataSource = .shared

}

extension SplashInteractor {
    
    public func fetchAuth() -> Future<UserAuth?, Never> {
        return localDataSource.getUserAuth()
    }
    
    public func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
    
    public func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remoteDataSource.refreshToken(refreshToken: request)
    }
}
