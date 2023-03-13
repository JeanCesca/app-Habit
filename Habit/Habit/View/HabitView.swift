//
//  HabitView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var vm: HabitViewModel
    
    var body: some View {
        
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            if case HabitUIState.loading = vm.uiState {
                progressView
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            if !vm.isCharts {
                                topContainer
                                addButton
                            }
                            
                            if case HabitUIState.emptyList = vm.uiState {
                                Spacer(minLength: 60)
                                alertHeader
                                
                            } else if case HabitUIState.fullList(let listRow) = vm.uiState {
                                VStack(spacing: 12) {
                                    ForEach(listRow) { row in
                                        HabitCardView(vm: row, isChart: vm.isCharts)
                                    }
                                }
                                
                            } else if case HabitUIState.error(let message) = vm.uiState {
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                        vm.presentAlert(message: message)
                                    }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Meus hábitos")
                }
            }
        }
        .onAppear {
            if !vm.opened {
                vm.fetchHabits()
            }
        }
    }
}

extension HabitView {
    var progressView: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(uiImage: vm.image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color("buttonColor"))
            Text(vm.description)
                .fontWidth(.expanded)
        }
        .foregroundColor(Color("buttonColor"))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay {
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color("buttonColor"), lineWidth: 0.5)
        }
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink {
            vm.habitCreateView()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color("buttonColor"))
                .cornerRadius(50)
        }
        .padding(.vertical, 20)
        .fontWidth(.expanded)
    }
}

extension HabitView {
    var alertHeader: some View {
        VStack {
            Text("Nenhum hábito encontrado.")
                .fontWidth(.expanded)
        }
        .foregroundColor(Color("buttonColor"))
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeViewRouter.makeHabitView(habitViewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
            }
            NavigationView {
                HomeViewRouter.makeHabitView(habitViewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
                    .preferredColorScheme(.dark)
            }
        }
    }
}
