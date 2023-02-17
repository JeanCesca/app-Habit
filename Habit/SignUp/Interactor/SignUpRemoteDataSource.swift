//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import SwiftUI
import Combine

class SignUpRemoteDataSource { //SINGLETON
    
    static let shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init() {}
    
    func registerUser(request: SignUpRequest) -> Future<Bool, AppError> {
        Future<Bool, AppError> { promise in
            WebService.requestCall_JSON(path: .postUser, method: .post, body: request) { result in
                switch result {
                case .success(_):
                    promise(.success(true))
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
