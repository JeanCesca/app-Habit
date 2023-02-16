//
//  SpashInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import Combine

class SplashInteractor {
    
//    private let remoteDataSource: SignInRemoteDataSource = .shared
    private let localDataSource: LocalDataSource = .shared

}

extension SplashInteractor {
    
    public func fetchAuth() -> Future<UserAuth?, Never> {
        return localDataSource.getUserAuth()
    }
}
