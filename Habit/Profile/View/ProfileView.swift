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
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite seu nome", text: $vm.fullNameValidation.value)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.alphabet)
                            vm.fullNameValidation.failure ?
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                            : Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $vm.email)
                                .disabled(true)
                                .multilineTextAlignment(.trailing)
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                        }
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("Digite seu CPF", text: $vm.document)
                                .disabled(true)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                        }
                        HStack {
                            Text("Telefone")
                            Spacer()
                            TextField("Digite seu celular", text: $vm.phoneValidation.value)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                            vm.phoneValidation.failure ?
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                            : Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                        }
                        HStack {
                            Text("Data de Nascimento")
                            Spacer(minLength: 1)
                            TextField("dd/MM/yyyy", text: $vm.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
                            vm.birthdayValidation.failure ?
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                            : Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                        }
                        NavigationLink {
                            GenderSelectorView(
                                title: "",
                                genders: Gender.allCases,
                                selectedGender: $vm.selectedGender)
                        } label: {
                            HStack {
                                Text("Gênero")
                                Spacer()
                                Text(vm.selectedGender?.rawValue ?? "")
                            }
                        }
                    } header: {
                        Text("Dados cadastrais")
                    }
                }
            }
            .navigationTitle("Editar Perfil")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel())
    }
}
