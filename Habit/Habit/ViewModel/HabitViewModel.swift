//
//  HabitViewModel.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import Foundation
import SwiftUI
import Combine

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var description: String = ""
    @Published var opened: Bool = false
    
    private let interactor: HabitInteractor
    
    //cancellable que atua no fetchHabits()
    private var cancellableRequest: AnyCancellable?
    
    //publisher "mãe"/instância que observa se deu True ou False na hora de criar um hábito na DetailView.
    private let habitPublisher: PassthroughSubject = PassthroughSubject<Bool, Never>()
    //cancellable que atua no publisher acima.
    private var cancellableNotify: AnyCancellable?

    
    init(interactor: HabitInteractor) {
        self.interactor = interactor
        updateHabits()
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func presentAlert(message: String) -> Alert {
        return Alert(
            title: Text("Ops! \(message)"),
            message: Text("Tentar novamente."),
            primaryButton: .default(Text("Sim")) {
                self.fetchHabits()
        },
            secondaryButton: .cancel())
    }
    
    public func fetchHabits() {
        self.opened = true
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.uiState = .error(error.message)
                }
            }, receiveValue: { [weak self] response in
                if response.isEmpty {
                    self?.uiState = .emptyList
                    self?.description = "Você ainda não possui hábitos!"
                } else {
                    self?.uiState = .fullList(
                        (self?.map(habitResponse: response))!
                    )
                }
            })
    }
    
    public func updateHabits() {
        cancellableNotify = habitPublisher
            .sink(receiveValue: { saved in
                self.fetchHabits()
            })
    }

    
    public func map(habitResponse response: [HabitResponse]) -> [HabitCardViewModel] {
        response.map { habit -> HabitCardViewModel in
            
            var state: Color = .green
            self.description = "Seus hábitos estão em dia"
            
            let lastDate = habit.lastDate?.dateToString(
                source: "yyyy-MM-dd'T'HH:mm:ss",
                destination: "dd/MM/yyyy HH:mm") ?? ""
            
            let dateToCompare = habit.lastDate?.stringToDate(source: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
            
            if dateToCompare < Date() {
                state = .red
                self.description = "Você está atrasado nos seus hábitos!"
            }
            
            return HabitCardViewModel(
                publisher: self.habitPublisher,
                id: habit.id,
                icon: habit.iconUrl ?? "",
                date: lastDate,
                name: habit.name,
                label: habit.label,
                value: "\(habit.value ?? 0)",
                state: state)
        }
    }
    
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//            var listRows: [HabitCardViewModel] = []
//
//            listRows.append(HabitCardViewModel(
//                id: 1,
//                icon: "https://via.placeholder.com/150",
//                date: "01/01/2023 00:00:00",
//                name: "Ouvir The Knife",
//                label: "horas",
//                value: "2",
//                state: .green))
//
//            listRows.append(HabitCardViewModel(
//                id: 2,
//                icon: "https://via.placeholder.com/150",
//                date: "01/01/2023 00:00:00",
//                name: "Ouvir The Strokes",
//                label: "horas",
//                value: "2",
//                state: .green))
//
//            listRows.append(HabitCardViewModel(
//                id: 3,
//                icon: "https://via.placeholder.com/150",
//                date: "01/01/2023 00:00:00",
//                name: "Malhar",
//                label: "horas",
//                value: "2",
//                state: .green))
            
//            self.uiState = .fullList(listRows)
//            self.uiState = .error("Falha interna no servidor!")


}
