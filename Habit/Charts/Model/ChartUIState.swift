//
//  ChartUIState.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/03/23.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
