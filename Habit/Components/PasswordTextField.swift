//
//  PasswordTextField.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var searchText: String
    let textFieldTitle: String
    
    var body: some View {
        SecureField(textFieldTitle, text: $searchText)
            .font(.headline)
            .foregroundColor(.blue)
            .autocorrectionDisabled()
            .padding()
            .background(
                Color.gray.opacity(0.1)
            )
            .cornerRadius(20)
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(searchText: .constant(""), textFieldTitle: "Olá")
    }
}
