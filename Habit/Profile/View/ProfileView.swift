//
//  ProfileView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel

    var body: some View {
        ZStack {
            
            if case ProfileUIState.loading = vm.uiState {
                ProgressView()
            } else {
                NavigationView {
                    VStack {
                        Form {
                            Section {
                                fullNameField
                                emailField
                                documentField
                                phoneField
                                birthdayField
                                genderField
                            } header: {
                                Text("Dados cadastrais")
                            }
                            
                        }
                    }
                    .navigationTitle("Editar Perfil")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                vm.updateUser()
                            } label: {
                                if case ProfileUIState.updateLoading = vm.uiState {
                                    ProgressView()
                                } else {
                                    checkmark
                                }
                            }
                            .alert("Yey!\nDados atualizados com sucesso!\n✨✨✨✨✨", isPresented: .constant(vm.uiState == .updateSuccess)) {
                                //todo after clicking: OK
                            }
                        }
                    }
                }
            }
            
            //Error screen for UPDATE
            if case ProfileUIState.updateError(let error) = vm.uiState {
                showAlert(title: "Erro ao editar dados do usuário!", message: "👾👾👾👾👾\n(\(error))")
            }

            //Error screen for FETCH
            if case ProfileUIState.fetchError(let error) = vm.uiState {
                showAlert(title: "Erro ao carregar dados do usuário!", message: "👾👾👾👾👾👾\n(\(error))")
            }
        }
        .onAppear {
            vm.fetchUser()
        }
    }
    
    var isDisabled: Bool {
        if vm.fullNameValidation.value.isEmpty
            || vm.phoneValidation.value.isEmpty
            || vm.birthdayValidation.value.isEmpty {
            return true
        } else if vm.fullNameValidation.failure
                    || vm.phoneValidation.failure
                    || vm.birthdayValidation.failure {
            return true
        } else {
            return false
        }
    }
}

extension ProfileView {
    var checkmark: some View {
        Image(systemName: "checkmark.seal")
            .resizable()
            .foregroundColor(.green)
            .frame(width: 35, height: 35)
            .bold()
            .padding()
            .opacity(
                isDisabled ? 0 : 1
            )
    }
}

extension ProfileView {
    var fullNameField: some View {
        HStack {
            Text("Nome")
            Spacer()
            TextField("Digite seu nome", text: $vm.fullNameValidation.value)
                .multilineTextAlignment(.trailing)
                .keyboardType(.alphabet)
            if vm.fullNameValidation.failure {
                Image(systemName: "xmark.seal")
                    .foregroundColor(.red)
            }
        }
    }
}

extension ProfileView {
    var emailField: some View {
        HStack {
            Text("E-mail")
            Spacer()
            TextField("", text: $vm.email)
                .disabled(true)
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var documentField: some View {
        HStack {
            Text("CPF")
            Spacer()
            TextField("Digite seu CPF", text: $vm.document)
                .disabled(true)
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var phoneField: some View {
        HStack {
            Text("Telefone")
            Spacer()
            TextField("ex. (00) 00000 0000", text: $vm.phoneValidation.value)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
            if vm.phoneValidation.failure {
                Image(systemName: "xmark.seal")
                    .foregroundColor(.red)
            }
        }
    }
}

extension ProfileView {
    var birthdayField: some View {
        HStack {
            Text("Data de Nascimento")
            Spacer()
            TextField("ex. dd/MM/yyyy", text: $vm.birthdayValidation.value)
                .multilineTextAlignment(.trailing)
            if vm.birthdayValidation.failure {
                Image(systemName: "xmark.seal")
                    .foregroundColor(.red)
            }
        }
    }
}

extension ProfileView {
    var genderField: some View {
        NavigationLink {
            GenderSelectorView(
                title: "",
                genders: Gender.allCases,
                selectedGender: $vm.gender)
        } label: {
            HStack {
                Text("Gênero")
                Spacer()
                Text(vm.gender?.rawValue ?? "")
            }
        }
    }
}

extension ProfileView {
    func showAlert(title: String, message: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text("Ok")) {
                        vm.uiState = .none
                })
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel(interactor: ProfileInteractor()))
    }
}
