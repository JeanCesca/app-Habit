//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/03/23.
//

import Foundation
import SwiftUI
import Combine

class ChartRemoteDataSource {
    
    static let shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    private init() {}
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        Future<[HabitValueResponse], AppError> { promise in
            
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.requestCall_ReadOnly_HabitValues(path: path, method: .get) { result in
                switch result {
                case .success(let data):
                    guard let response = try? JSONDecoder().decode([HabitValueResponse].self, from: data) else {
                        print("Erro ao fazer parse do HabitValues")
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
