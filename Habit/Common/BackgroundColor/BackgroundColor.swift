//
//  BackgroundColor.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import SwiftUI

struct BackgroundColor: View {
    let colors = [Color("buttonColor").opacity(0.1), Color.accentColor.opacity(0.1)]

    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
