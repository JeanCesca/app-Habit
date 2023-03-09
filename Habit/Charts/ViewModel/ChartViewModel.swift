//
//  ChartViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 03/03/23.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var uiState: ChartUIState = .loading
    
    @Published var entries: [ChartDataEntry] = []
    @Published var dates: [String] = []
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
    }
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.uiState = .error(error.message)
                }
            } receiveValue: { [weak self] response in
                self?.uiState = .fullChart
            }
    }
}
