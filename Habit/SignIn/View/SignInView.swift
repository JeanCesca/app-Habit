//
//  SignInView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var action: Int? = 0
    @State private var navigationHidden: Bool = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        imageLogo
                        emailTextField
                        passwordTextField
                        enterButton
                        registerFields
                        copyright
                        
                        if case SignInUIState.error(let value) = viewModel.uiState {
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
            placeholder: "E-mail",
            error: "E-mail inválido",
            failure: !email.isEmail(),
            keyboard: .emailAddress,
            isSecure: false,
            text: $email)
    }
}

extension SignInView {
    var passwordTextField: some View {
        EditTextView(
            placeholder: "Password",
            error: "Senha deve ter ao menos 8 caracteres.",
            failure: password.count < 8,
            keyboard: .emailAddress,
            isSecure: true,
            text: $password)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login(email: email, password: password)
        },
        text: "Entrar",
        showProgressBar: self.viewModel.uiState == SignInUIState.loading,
        disabled: !email.isEmail() || password.count < 8)
    }
}

extension SignInView {
    var registerFields: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top)
            ZStack {
                NavigationLink(tag: 1, selection: $action, destination: {
                    viewModel.signUpView()
                }) {
                    EmptyView()
                }
                Button("Realize seu cadastro") {
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
            SignInView(viewModel: SignInViewModel())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
                .previewLayout(.sizeThatFits)
        }
    }
}
