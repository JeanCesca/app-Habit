//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static let shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init() {}
    
    func refreshToken(refreshToken request: RefreshRequest) -> Future<SignInResponse, AppError> {
        
        Future<SignInResponse, AppError> { promise in
            
            WebService.requestCall_JSON(path: .refreshToken, method: .put, body: request) { result in
                switch result {
                case .success(let data):
                    let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                    guard let response = response else {
                        print("Log: Error de parser \(String(describing: String(data: data, encoding: .utf8)))")
                        return
                    }
                    promise(.success(response))
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unAuthorized {
                            let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
                            promise(.failure(.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                }
            }
        }
    }
}
