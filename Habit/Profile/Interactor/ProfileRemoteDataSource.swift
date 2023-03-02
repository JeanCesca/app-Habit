//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static let shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init() {}
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        Future<ProfileResponse, AppError> { promise in
            WebService.requestCall_JSON_ReadOnly(path: .fetchUser, method: .get) { result in
                switch result {
                case .success(let data):
                    guard let response = try? JSONDecoder().decode(ProfileResponse.self, from: data) else {
                        print("Log: Error de 'fetch user' \(String(describing: String(data: data, encoding: .utf8)))")
                        return
                    }
                    promise(.success(response))
                case .failure(_, let data):
                    if let data = data {
                        let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no Servidor")))
                    }
                }
            }
        }
    }
}
