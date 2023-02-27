//
//  ButtonStyle.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import SwiftUI

struct ButtonStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 26)
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(.title3)
            .fontWeight(.semibold)
            .background(
                Color("buttonColor")
            )
            .cornerRadius(20)
    }
}
