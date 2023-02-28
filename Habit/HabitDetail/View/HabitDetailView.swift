//
//  HabitDetailView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 28/02/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var vm: HabitDetailViewModel
    
    init(vm: HabitDetailViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(vm.name)
                    .foregroundColor(Color("buttonColor"))
                    .font(.title3.bold())
                
                Text("Unidade: \(vm.label)\n")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $vm.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                Divider()
                    .frame(height: 1)
                    .background(.gray)
            }
            .padding(.horizontal)
            
            Text("Os registros devem ser feito em até 24h")
            Text("Hábitos se constroem todos os dias 🐸")
            
            LoadingButtonView(action: {
                
            }, text: "Salvar", showProgressBar: self.vm.uiState == .loading, disabled: self.vm.value.isEmpty)
            .padding(.horizontal)
            .padding(.top, 28)
            
            Button("Cancelar") {
                //dismiss
            }
            .modifier(ButtonStyle())
            .padding()
            
            Spacer()
        }
        .padding(.top, 60)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(vm: HabitDetailViewModel(
                id: 1,
                name: "Ouvir The Knife - Networking",
                label: "2h"))
                .preferredColorScheme($0)
        }
    }
}
