//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    
    @Published var name: String = ""
    @Published var label: String = ""
    
    @Published var image: Image? = Image(systemName: "camera.circle")
    @Published var imageData: Data? = nil
    @Published var text: String? = "Carregue sua foto"
    
    private var interactor: HabitDetailInteractor
    private var cancellable: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    
    init(interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    public func save() {
        self.uiState = .loading
        
    }
}
