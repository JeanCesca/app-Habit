//
//  ChartViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 03/03/23.
//

import Foundation
import SwiftUI
import Charts


class ChartViewModel: ObservableObject {
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 8.0),
        ChartDataEntry(x: 4.0, y: 1.0),
        ChartDataEntry(x: 5.0, y: 5.0),
        ChartDataEntry(x: 6.0, y: 6.0),
        ChartDataEntry(x: 7.0, y: 9.0),
        ChartDataEntry(x: 8.0, y: 4.0),
        ChartDataEntry(x: 9.0, y: 2.0),
        ChartDataEntry(x: 10.0, y: 20.0),
    ]
    
    @Published var dates: [String] = [
        "01/01/2023",
        "02/01/2023",
        "03/01/2023",
        "04/01/2023",
        "05/01/2023",
        "06/01/2023",
        "07/01/2023",
        "08/01/2023",
        "09/01/2023",
        "10/01/2023",
        ]
    
}
