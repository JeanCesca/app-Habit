//
//  HabitDetailView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var vm: HabitDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    init(vm: HabitDetailViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                    header
                
                VStack {
                    TextField("Valor conquistado", text: $vm.value)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(.plain)
                        .keyboardType(.numberPad)
                        .fontWidth(.expanded)
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                }
                
                VStack {
                    Text("Os registros devem ser feito em até 24h.")
                        .foregroundColor(.accentColor)
                }

                VStack(spacing: 10) {
                    LoadingButtonView(action: {
                        self.vm.save()
                    }, text: "Salvar", showProgressBar: self.vm.uiState == .loading, disabled: self.vm.value.isEmpty)
                    
                    Button("Cancelar") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.easeOut(duration: 1)) {
                                self.dismiss()
                            }
                        }
                    }
                    .modifier(ButtonStyle())
                }
                .padding(.top, 12)
                Spacer()
            }
            .padding(.top, 60)
            .onAppear {
                vm.$uiState
                    .sink { uiState in
                        if uiState == .success {
                            self.dismiss()
                        }
                    }
                    .store(in: &vm.cancellables)
        }
            .padding(.horizontal, 20)
        }
    }
}

extension HabitDetailView {
    var header: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(vm.name)
                .foregroundColor(Color("buttonColor"))
                .fontWidth(.expanded)
                .bold()
            Text("Unidade: \(vm.label)\n")
                .fontWidth(.expanded)
                .fontWeight(.light)
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(vm: HabitDetailViewModel(
                id: 1,
                name: "Ouvir The Knife - Networking",
                label: "2h",
                interactor: HabitDetailInteractor()))
            .preferredColorScheme($0)
        }
    }
}
