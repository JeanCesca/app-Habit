//
//  HabitCreateView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/03/23.
//

import SwiftUI


struct HabitCreateView: View {
    
    @ObservedObject var vm: HabitCreateViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var shouldPresentCamera: Bool = false
    
    init(vm: HabitCreateViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 12) {
                    photoButton
                }
                
                VStack(spacing: 25) {
                    habitName
                    habitUnit
                    
                    LoadingButtonView(action: {
                        
                    }, text: "Salvar", showProgressBar: self.vm.uiState == .loading, disabled: self.vm.name.isEmpty || self.vm.label.isEmpty)
                    .fontWidth(.expanded)
//                    cancelButton
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

extension HabitCreateView {
    var photoButton: some View {
        Button {
            self.shouldPresentCamera = true
        } label: {
            VStack {
                vm.image!
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                Text(vm.text ?? "Carregue sua foto")
                    .fontWidth(.expanded)
            }
        }
        .padding(.bottom, 50)
        .sheet(isPresented: $shouldPresentCamera) {
            ImagePickerView(
                isPresented: $shouldPresentCamera,
                image: $vm.image,
                imageData: $vm.imageData,
                text: $vm.text,
                sourceType: .camera)
        }
    }
}

extension HabitCreateView {
    var habitName: some View {
        VStack {
            TextField("Nome do hábito.", text: $vm.name)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.plain)
                .fontWidth(.expanded)
            Divider()
                .frame(height: 1)
                .background(.gray)
        }
    }
}

extension HabitCreateView {
    var habitUnit: some View {
        VStack {
            TextField("Unidade de medida.", text: $vm.label)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.plain)
                .fontWidth(.expanded)
            Divider()
                .frame(height: 1)
                .background(.gray)
        }
    }
}

extension HabitCreateView {
    var cancelButton: some View {
        Button("Cancelar") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeOut(duration: 1)) {
                    //
                }
            }
        }
        .modifier(ButtonStyle())
    }
}

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitCreateView(vm: HabitCreateViewModel(interactor: HabitDetailInteractor()))
                .preferredColorScheme($0)
        }
    }
}
