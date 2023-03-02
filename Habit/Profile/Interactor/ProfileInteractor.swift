//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    
    public func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
}
