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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 20)
                        
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
            error: "Nome deve conter mais que três letras",
            failure: vm.fullName.count < 3,
            keyboard: .default,
            text: $vm.fullName)
    }
}

extension SignUpView {
    var emailTextField: some View {
        EditTextView(
            placeholder: "E-mail",
            error: "E-mail deve ser válido",
            failure: !vm.email.isEmail(),
            keyboard: .emailAddress,
            text: $vm.email)
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
    }
}

extension SignUpView {
    var documentTextField: some View {
        EditTextView(
            placeholder: "CPF Válido",
            error: "Insira um CPF válido",
            failure: vm.document.count != 11,
            keyboard: .numberPad,
            text: $vm.document)
    }
}

extension SignUpView {
    var phoneTextField: some View {
        EditTextView(
            placeholder: "(00) 00000-0000",
            error: "Número com o DDD + 8 ou 9 dígitos",
            failure: vm.phone.count < 10 || vm.phone.count >= 12,
            keyboard: .emailAddress,
            isSecure: false,
            text: $vm.phone)
    }
}

extension SignUpView {
    var birthdayTextField: some View {
        EditTextView(
            placeholder: "Data de Nascimento",
            error: "A data deve ser no padrão dd/MM/yyyy",
            failure: vm.birthday.count != 10,
            keyboard: .numberPad,
            isSecure: false,
            text: $vm.birthday)
    }
}

extension SignUpView {
    var genderPicker: some View {
        Picker("Gênero", selection: $vm.gender) {
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
                          vm.document.count != 11 ||
                          vm.phone.count < 10 ||
                          vm.phone.count >= 12 ||
                          vm.birthday.count != 10
    )}
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView(vm: SignUpViewModel())
                .preferredColorScheme(.light)
            SignUpView(vm: SignUpViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
