//
//  SignInView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var vm: SignInViewModel
    
    @State var action: Int? = 0
    @State var navigationHidden: Bool = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = vm.uiState {
                vm.homeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        imageLogo
                        emailTextField
                        passwordTextField
                        enterButton
                        registerFields
                        copyright
                        
                        if case SignInUIState.error(let value) = vm.uiState {
                            showAlert(value: value)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal)
                    .navigationTitle("Login").navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
    var imageLogo: some View {
        VStack(alignment: .center) {
            Image("doglogin")
                .resizable()
                .scaledToFit()
                .padding(80)
        }
    }
}

extension SignInView {
    var emailTextField: some View {
        EditTextView(
            placeholder: "✉️ E-mail",
            error: "E-mail inválido",
            failure: !vm.email.isEmail(),
            keyboard: .emailAddress,
            isSecure: false,
            text: $vm.email)
    }
}

extension SignInView {
    var passwordTextField: some View {
        EditTextView(
            placeholder: "🔑 Password",
            error: "Senha deve ter ao menos 8 caracteres.",
            failure: vm.password.count < 8,
            keyboard: .emailAddress,
            isSecure: true,
            text: $vm.password)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            vm.login()
        },
        text: "Entrar",
        showProgressBar: self.vm.uiState == SignInUIState.loading,
                          disabled: !vm.email.isEmail() || vm.password.count < 8)
    }
}

extension SignInView {
    var registerFields: some View {
        VStack {
            Text("Não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top)
            ZStack {
                NavigationLink(tag: 1, selection: $action, destination: {
                    vm.signUpView()
                }) {
                    EmptyView()
                }
                Button("Cadastre-se!") {
                    self.action = 1
                }
            }
        }
    }
}

extension SignInView {
    var copyright: some View {
        Text("Copyright @YYY")
            .foregroundColor(.gray)
            .font(.system(size: 16).monospacedDigit())
            .padding(.top, 120)
    }
}

extension SignInView {
    func showAlert(value: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text("Erro!"),
                    message: Text(value),
                    dismissButton: .default(Text("Ok")) {
                    //faz algo quando some o alerta
                })
            }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView(vm: SignInViewModel())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
                .previewLayout(.sizeThatFits)
        }
    }
}
