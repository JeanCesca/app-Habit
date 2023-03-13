//
//  ChartView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @StateObject var vm: ChartViewModel
    
    var body: some View {
        
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            if case ChartUIState.loading = vm.uiState {
                ProgressView()
            } else {
                
                if case ChartUIState.emptyChart = vm.uiState {
                    VStack {
                        Text("Nenhum hábito encontrado.")
                    }
                } else if case ChartUIState.error(let error) = vm.uiState {
                    showAlert(title: "Erro ao carregar!", message: "👾👾👾👾👾\n(\(error))")
                } else {
                    BoxChartView(entries: $vm.entries, dates: $vm.dates)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .padding()
                }
            }
        }
        .onAppear {
            vm.onAppear()
        }
    } 
}

extension ChartView {
    func showAlert(title: String, message: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text("Ok")) {
                        //
                })
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartView(vm: ChartViewModel(habitId: 1, interactor: ChartInteractor()))
            ChartView(vm: ChartViewModel(habitId: 2, interactor: ChartInteractor()))
                .preferredColorScheme(.dark)
        }
    }
}
