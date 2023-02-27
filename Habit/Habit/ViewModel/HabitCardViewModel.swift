//
//  HabitCardViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Foundation
import SwiftUI

struct HabitCardViewModel: Identifiable, Equatable {
    
    var id: Int = 0
    
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
