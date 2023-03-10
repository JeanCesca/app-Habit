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
                if response.isEmpty {
                    self?.uiState = .emptyChart
                } else {
                    self?.uiState = .fullChart
                    
                    //mapping [HabitValueResponse] -> [String]
                    let mappedResponse = response.map({ return $0.createdDate })
                    self?.dates = mappedResponse
                    
                    //indice para X e Y
                    self?.entries = zip(response.startIndex..<response.endIndex, response)
                        .map { index, response in
                            ChartDataEntry(x: Double(index), y: Double(response.value))
                        }
                }
            }
    }
}
