//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("backgroundTextField"))
            )
    }
    
}
