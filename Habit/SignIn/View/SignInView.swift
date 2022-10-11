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
    
    @State var email = ""
    @State var password = ""
    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        if case SignInUIState.goToHomeScreen = viewModel.uiState {
            viewModel.homeView()
            
        } else {
            NavigationView {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .center) {
                        Image("doglogin")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 60)
                            .padding(.top, 100)
                            .padding(.bottom, 20)
                        
                        Text("Login")
                            .foregroundColor(.orange)
                            .font(Font.system(.title2).bold())
                            .padding(.bottom, 8)
                        
                        emailField
                        
                        passwordField
                        
                        enterButton
                        
                        registerLink
                        
                        Text("Copyright @YYY")
                            .foregroundColor(.gray)
                            .font(.system(size: 16).monospacedDigit())
                            .padding(.top, 120)
                    }
                    
                    if case SignInUIState.error(let value) = viewModel.uiState {
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(title: Text("Erro!"), message: Text(value), dismissButton: .default(Text("Ok")) {
                                    //faz algo quando some o alerta
                                })
                            }
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
                .background(.white)
                .navigationTitle("Login").navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(navigationHidden)
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        TextField("seu usuário", text: $email)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("senha", text: $password)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Entrar") {
            viewModel.login(email: email, password: password)
        }
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel()
        SignInView(viewModel: viewModel)
    }
}
