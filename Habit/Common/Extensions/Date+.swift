//
//  Date+.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import Foundation

extension Date {
    func dateToString(destination: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = destination
        
        let dateFormatted = formatter.string(from: self)
        return dateFormatted
    }
}
