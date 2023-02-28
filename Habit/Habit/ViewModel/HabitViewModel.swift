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
    
    @Published var title: String = ""
    @Published var description: String = ""
    
    private let interactor: HabitInteractor
    
    private var cancellableRequest: AnyCancellable?

    
    init(interactor: HabitInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func presentAlert(message: String) -> Alert {
        return Alert(
            title: Text("Ops! \(message)"),
            message: Text("Tentar novamente."),
            primaryButton: .default(Text("Sim")) {
                self.onAppear()
        },
            secondaryButton: .cancel())
    }
    
    func onAppear() {
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    self.title = ""
                    self.description = "Você ainda não possui hábitos!"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.stringToDate(
                                source: "yyyy-MM-dd'T'HH:mm:ss",
                                destination: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom :)"
                            self.description = ""
                            
                            if lastDate < Date().dateToString(destination: "dd/MM/yyyy") {
                                state = .red
                                self.title = "Atenção"
                                self.description = "Você está atrasado nos seus hábitos!"
                            }
                            
                            return HabitCardViewModel(
                                id: $0.id,
                                icon: $0.iconUrl ?? "",
                                date: lastDate,
                                name: $0.name,
                                label: $0.label,
                                value: "\($0.value ?? 0)",
                                state: state)
                        }
                    ) //veio em HabitResponse, preciso converter p/ HabitCardViewModel
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
    )}
}
