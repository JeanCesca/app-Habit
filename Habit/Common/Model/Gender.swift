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
    
    case cisMale = "Homem Cisgênero"
    case cisFem = "Mulher Cisgênero"
    case nonBinary = "Não Binárie"
    case transFem = "Mulher Transgênera"
    case transMale = "Homem Transgênero"

    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex(where: { self == $0 }) ?? 0
    }
}

