//
//  LocalDataSource.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 16/02/23.
//

import Foundation
import Combine

class LocalDataSource {
    
    static let shared: LocalDataSource = LocalDataSource()
    
    private init() {}
    
    let userKey: String = "user_key"
    
    private let userDefaults: UserDefaults = .standard
    private var userAuth: UserAuth?
    
    private func saveValue(value: UserAuth) {
        //Encoda o valor do UserAuth para salvar
        userDefaults.setValue(try? PropertyListEncoder().encode(value), forKey: userKey)
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        //Para let, faço a decodificação o UserAuth
        var userAuth: UserAuth?
        
        if let data = userDefaults.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: userKey)
        
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
