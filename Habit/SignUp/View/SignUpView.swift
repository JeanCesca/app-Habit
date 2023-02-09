//
//  SignUpView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var document: String = ""
    @State var phone: String = ""
    @State var birthday: String = ""
    @State var gender: Gender = Gender.male
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 20)
                        
//                        SignTextField(searchText: $fullName, textFieldTitle: "Nome completo")
//                        SignTextField(searchText: $email, textFieldTitle: "E-mail")
//                        PasswordTextField(searchText: $password, textFieldTitle: "Senha")
//                        SignTextField(searchText: $document, textFieldTitle: "Documento")
//                        SignTextField(searchText: $phone, textFieldTitle: "Telefone")
//                        SignTextField(searchText: $birthday, textFieldTitle: "Documento")
//                        signUpPicker
//                        SaveButton(text: "Realize seu cadastro") {
//                            viewModel.signUp()
//                        }
                    }
                    Spacer()
                }
                .padding()
            }
            
            if case SignUpUIState.error(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Erro!"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            //faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var signUpPicker: some View {
        Picker("Gênero", selection: $gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text("\(value.rawValue)")
                    .tag(value)
            }
        }
        .pickerStyle(.segmented)
        .padding(.top, 18)
        .padding(.bottom, 18)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
