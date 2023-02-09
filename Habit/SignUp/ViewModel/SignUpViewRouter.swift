//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI
import Combine

enum SignUpViewRouter {
    
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
