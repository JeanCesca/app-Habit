//
//  Mask.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 13/03/23.
//

import Foundation

class Mask {
    
    static var isUpdating: Bool = false
    static var oldString: String = ""
    
    private static func replaceChars(full: String) -> String {
        full
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    static func mask(mask: String, value: String, text: inout String) {
        let cleanString = Mask.replaceChars(full: value)
        
        var documentWithMask = ""
        
        var _mask = mask
        
        if (_mask == "(##) ####-####") {
            if (value.count >= 14 && value.characterAtIndex(index: 5) == "9") {
                _mask = "(##) #####-####"
            }
        }
        
        if cleanString <= oldString {
            isUpdating = true
            
            if _mask == "(##) #####-####" && value.count == 14 {
                _mask = "(##) ####-####"
            }
        }
        
        if (isUpdating || value.count == mask.count) {
            oldString = cleanString
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if char != "#" && cleanString.count > oldString.count {
                documentWithMask = documentWithMask + String(char)
                continue
            }
            
            
            let unNamed = cleanString.characterAtIndex(index: i)
            guard let char = unNamed else { break }
            documentWithMask = documentWithMask + String(char)
            
            i = i + 1
            
            text = documentWithMask
        }
        
        isUpdating = true
        
        if documentWithMask == "(0" {
            text = ""
            return
        }
        
        text = documentWithMask
    }
}
