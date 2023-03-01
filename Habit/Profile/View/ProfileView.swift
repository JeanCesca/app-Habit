//
//  ProfileView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    @State var fullName: String = ""
    @State var email: String = "teste@gmail.com"
    @State var document: String = "111.222.333-11"
    @State var phone: String = "(11) 9 9393-8998"
    @State var birthday: String = "03/10/1992"
    
    @State var selectedGender: Gender? = .male

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite seu nome", text: $fullName)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.alphabet)
                        }
                        HStack {
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $email)
                                .disabled(true)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("Digite seu CPF", text: $document)
                                .disabled(true)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Text("Telefone")
                            Spacer()
                            TextField("Digite seu celular", text: $phone)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Text("Data de Nascimento")
                            Spacer(minLength: 4)
                            TextField("Digite sua data de nascimento", text: $birthday)
                                .multilineTextAlignment(.trailing)
                        }
                        NavigationLink {
                            GenderSelectorView(
                                title: "",
                                genders: Gender.allCases,
                                selectedGender: $selectedGender)
                        } label: {
                            HStack {
                                Text("Gênero")
                                Spacer()
                                Text(selectedGender?.rawValue ?? "")
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
