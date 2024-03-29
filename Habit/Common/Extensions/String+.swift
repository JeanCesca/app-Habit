//
//  String+.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import Foundation

extension String {
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        
        for char in self {
            if cur == index {
                return char
            }
            cur = cur + 1
        }
        return nil
    }
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func dateToString(source: String, destination: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        //Validar a Data
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        //Date -> String
        formatter.dateFormat = destination
        return formatter.string(from: dateFormatted)
    }
    
    func stringToDate(source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}
