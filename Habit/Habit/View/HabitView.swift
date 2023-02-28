//
//  HabitView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import SwiftUI

struct HabitView: View {
    
    @StateObject var vm: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = vm.uiState {
                progressView
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            topContainer
                            addButton
                            
                            if case HabitUIState.emptyList = vm.uiState {
                                Spacer(minLength: 60)
                                alertHeader
                                
                            } else if case HabitUIState.fullList(let listRow) = vm.uiState {
                                LazyVStack(spacing: 12) {
                                    ForEach(listRow, content: HabitCardView.init(vm:))
                                }
                                .padding(.horizontal, 16)
                                
                            } else if case HabitUIState.error(let message) = vm.uiState {
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                        vm.presentAlert(message: message)
                                    }
                            }
                        }
                    }
                    .navigationTitle("Meus hábitos")
                }
            }
        }
        .onAppear {
            if !vm.opened {
                vm.onAppear()
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
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color("buttonColor"))
            Text(vm.description)
                .font(.callout)
                .foregroundColor(Color("buttonColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay {
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.gray, lineWidth: 1)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink {
            Text("Tela de add")
                .frame(maxWidth: .infinity)
        } label: {
            Label("Criar hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(16)
    }
}

extension HabitView {
    var alertHeader: some View {
        VStack {
            Image(systemName: "exclamationmark.octagon")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14, alignment: .center)
            
            Text("Nenhum hábito encontrado :(")
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeViewRouter.makeHabitView(habitViewModel: HabitViewModel(interactor: HabitInteractor()))
            }
            NavigationView {
                HomeViewRouter.makeHabitView(habitViewModel: HabitViewModel(interactor: HabitInteractor()))
                    .preferredColorScheme(.dark)
            }
        }
    }
}
