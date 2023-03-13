//
//  SignUpView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var vm: SignUpViewModel
    
    var body: some View {
        
        ZStack {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 10) {
                            fullNameTextField
                            emailTextField
                            passwordTextField
                            documentTextField
                            phoneTextField
                            birthdayTextField
                            genderPicker
                            
                            enterButton
                        }
                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("Cadastro")
            }
            
            if case SignUpUIState.error(let error) = vm.uiState {
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
    var fullNameTextField: some View {
        EditTextView(
            placeholder: "Nome completo",
            mask: nil,
            error: "Nome deve conter mais que três letras",
            failure: vm.fullName.count < 3,
            keyboard: .default,
            autoCapitalization: .words,
            text: $vm.fullName
        )
        .fontWidth(.expanded)
        .padding(2)
    }
}

extension SignUpView {
    var emailTextField: some View {
        EditTextView(
            placeholder: "E-mail",
            mask: nil,
            error: "E-mail deve ser válido",
            failure: !vm.email.isEmail(),
            keyboard: .emailAddress,
            autoCapitalization: .never,
            text: $vm.email)
        .fontWidth(.expanded)
    }
}

extension SignUpView {
    var passwordTextField: some View {
        EditTextView(
            placeholder: "Senha",
            error: "Senha deve possuir mais que 8 caracteres",
            failure: vm.password.count < 8,
            keyboard: .default,
            isSecure: true,
            text: $vm.password)
        .fontWidth(.expanded)
    }
}

extension SignUpView {
    var documentTextField: some View {
        EditTextView(
            placeholder: "CPF Válido",
            mask: "###.###.###-##",
            error: "Insira um CPF válido",
            failure: vm.document.count != 14,
            keyboard: .numberPad,
            text: $vm.document)
        .fontWidth(.expanded)
    }
}

extension SignUpView {
    var phoneTextField: some View {
        EditTextView(
            placeholder: "Cel. (00) 00000-0000",
            mask: "(##) ####-####",
            error: "Número com o DDD + 8 ou 9 dígitos",
            failure: vm.phone.count < 14 || vm.phone.count >= 16,
            keyboard: .emailAddress,
            isSecure: false,
            text: $vm.phone)
        .fontWidth(.expanded)
    }
}

extension SignUpView {
    var birthdayTextField: some View {
        EditTextView(
            placeholder: "Data de Nascimento",
            mask: "##/##/####",
            error: "A data deve ser no padrão 00/00/0000",
            failure: vm.birthday.count != 10,
            keyboard: .numberPad,
            isSecure: false,
            text: $vm.birthday)
        .fontWidth(.expanded)
    }
}

extension SignUpView {
    var genderPicker: some View {
        Picker("Gênero", selection: $vm.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text("\(value.rawValue)")
                    .tag(value)
                    .font(.title)
            }
        }
        
        .pickerStyle(.menu)
        .padding(.top, 18)
        .padding(.bottom, 18)
    }
}

extension SignUpView {
    var enterButton: some View {
        LoadingButtonView(action: {
            vm.signUp()
        },
        text: "Cadastrar",
                          showProgressBar: self.vm.uiState == SignUpUIState.loading,
                          disabled: !vm.email.isEmail() ||
                          vm.password.count < 8 ||
                          vm.fullName.count < 3 ||
                          vm.document.count != 14 ||
                          vm.phone.count < 14 ||
                          vm.phone.count >= 16 ||
                          vm.birthday.count != 10
    )
        .fontWidth(.expanded)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView(vm: SignUpViewModel(interactor: SignUpInteractor()))
                .preferredColorScheme(.light)
            SignUpView(vm: SignUpViewModel(interactor: SignUpInteractor()))
                .preferredColorScheme(.dark)
        }
    }
}
