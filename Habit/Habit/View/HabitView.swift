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
                                
                                VStack {
                                    Image(systemName: "exclamationmark.octagon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                                
                                
                            } else if case HabitUIState.emptyList = vm.uiState {
                                
                            } else if case HabitUIState.error = vm.uiState {
                                
                            }
                        }
                    }
                    .navigationTitle("Meus hábitos")
                }
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
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color("buttonColor"))
            Text(vm.title)
                .font(.title2)
                .foregroundColor(Color("buttonColor"))
                .monospaced()
            Text(vm.description)
                .font(.callout)
                .foregroundColor(Color("textColor"))
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
                .monospaced()
                .modifier(ButtonStyle())
        }
        .padding(16)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeViewRouter.makeHabitView()
            }
            NavigationView {
                HomeViewRouter.makeHabitView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
