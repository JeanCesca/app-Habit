//
//  HabitCardViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Combine
import SwiftUI

struct HabitCardViewModel: Identifiable, Equatable {
    
    let publisher: PassthroughSubject<Bool, Never>
    
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

extension HabitCardViewModel {
    
    public func habitDetailView() -> some View {
        return HabitCardViewRouter.makeHabitDetailView(id: id, name: name, label: label, habitPublisher: publisher)
    }
    
    public func chartView() -> some View {
        return HabitCardViewRouter.makeChartView(id: id)
    }
}
