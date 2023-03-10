//
//  HabitCreateDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import Combine
import SwiftUI

class HabitCreateRemoteDataSource {
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init() {}
    
    public func saveHabit(request: HabitCreateRequest) -> Future<Void, AppError> {
        
        let params: [URLQueryItem] = [
            URLQueryItem(name: "name", value: request.name),
            URLQueryItem(name: "label", value: request.label)
        ]
        
        return Future<Void, AppError> { promise in
            WebService.requestCall_FormData(path: .habits, params: params) { result in
                switch result {
                case .success(_):
                    promise(.success(()))
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unAuthorized {
                            let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
                        }
                    }
                }
            }
        }
    }
}
