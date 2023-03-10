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
    
    @Published var uiState: HabitCreateUIState = .none
    
    @Published var name: String = ""
    @Published var label: String = ""
    
    @Published var image: Image? = Image(systemName: "camera.circle")
    @Published var imageData: Data? = nil
    @Published var text: String? = "Carregue sua foto"
    
    private var interactor: HabitCreateInteractor
    private var cancellable: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    
    init(interactor: HabitCreateInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    public func saveHabit() {
        self.uiState = .loading
        
        cancellable = interactor.saveHabits(habitCreate: HabitCreateRequest(
            imageData: imageData,
            name: name,
            label: label))
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.uiState = .error(error.message)
            case .finished:
                break
            }
        }, receiveValue: { [weak self] _ in
            self?.uiState = .success
            self?.habitPublisher?.send(true)
        })
    }
}
