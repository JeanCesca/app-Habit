//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation
import Combine

class HabitRemoteDataSource { //SINGLETON
    
    static let shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init() {}
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        
        Future<[HabitResponse], AppError> { promise in
            
            WebService.requestCall_JSON_ReadOnly(path: .habits, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
                        promise(.failure(.response(message: response?.detail.message ?? "Erro desconhecido")))
                    }
                case .success(let data):
                    guard let response = try? JSONDecoder().decode([HabitResponse].self, from: data) else {
                        return
                    }
                    promise(.success(response))
                }
            }
        }
    }
}
