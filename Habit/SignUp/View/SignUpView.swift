//
//  SignUpView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import SwiftUI

struct SignUpView: View {
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    //TODO: gender
    
    var body: some View {
        
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 20)
                        
                        fullname
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        saveButton
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding()
            
        }
    }
}

extension SignUpView {
    var fullname: some View {
        TextField("nome", text: $fullName)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("seu usuário", text: $email)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var passwordField: some View {
        SecureField("senha", text: $password)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var documentField: some View {
        SecureField("cpf", text: $document)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var phoneField: some View {
        SecureField("telefone", text: $phone)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var birthdayField: some View {
        SecureField("data de nascimento", text: $birthday)
            .border(.gray, width: 1)
            .cornerRadius(10)
    }
}

extension SignUpView {
    var saveButton: some View {
        Button("Realize o seu cadastro.") {
            // viewModel.????
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
