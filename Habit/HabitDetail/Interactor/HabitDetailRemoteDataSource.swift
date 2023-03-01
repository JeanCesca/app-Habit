//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    
    static let shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {}
    
    func saveValue(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        
        Future<Bool, AppError> { promise in
            
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.requestCall_JSON(path: path, method: .post, body: request) { result in
                switch result {
                case .success(_):
                    promise(.success(true))
                case .failure(_, let data):
                    if let data = data {
                        let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
                        promise(.failure(.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                }
            }
        }
    }
}
