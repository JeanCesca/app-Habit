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
                        loginFields
                        registerFields
                        copyright
                        
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            showAlert(value: value)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal)
                    .background(.white)
                    .navigationTitle("Login").navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
    var loginFields: some View {
        VStack(alignment: .center) {
            Image("doglogin")
                .resizable()
                .scaledToFit()
                .padding(80)
            
            SignTextField(searchText: $email, textFieldTitle: "Seu usuário")
            PasswordTextField(searchText: $password, textFieldTitle: "Senha")
            Button("Entrar") {
                viewModel.login(email: email, password: password)
            }
        }
    }
}

extension SignInView {
    var registerFields: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            ZStack {
//                NavigationLink {
//                    viewModel.signUpView()
//                } label: {
//                    Text("Clique aqui")
//                }

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
        SignInView(viewModel: SignInViewModel())
    }
}
