//
//  Gender.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation

//CaseIterable: para poder fazer o ForEach
//Identifiable: para o ForEach interpretar cada elemento como sendo único

enum Gender: String, CaseIterable, Identifiable {
    
    case cisMale = "Homem Cis"
    case cisFem = "Mulher Cis"
    case nonBinary = "Não Binárie"
    case transFem = "Mulher Trans"
    case transMale = "Homem Trans"
    case notInformed = "Não informado"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex(where: { self == $0 }) ?? 0
    }
}

