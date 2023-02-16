//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation
import Combine

class RemoteDataSource { //SINGLETON
    
    static let shared: RemoteDataSource = RemoteDataSource()
    
    private init() {}
    
    func loginUser(request: SignInRequest) -> Future<SignInResponse, AppError> {
        
        Future<SignInResponse, AppError> { promise in
            
            let params: [URLQueryItem] = [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]
            
            WebService.requestCall_FormatData(path: .loginUser, params: params) { result in
                switch result {
                    
                case .success(let data):
                    let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
//                    completion(response, nil)
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
//                            completion(nil, response)
                        }
                    }
                }
            }
            
        }
    }
    
}
