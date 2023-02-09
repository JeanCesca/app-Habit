//
//  EditTextView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct EditTextView: View {
    
    var placeholder: String = ""
    var error: String? = nil
    var failure: Bool = false
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(.headline)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocorrectionDisabled()
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .font(.headline)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocorrectionDisabled()
                    .textFieldStyle(CustomTextFieldStyle())
            }
            
            if let error = error, failure == true, !text.isEmpty {
                ZStack {
                    Text(error)
                        .foregroundColor(.red.opacity(0.8))
                }
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(placeholder: "E-mail", error: "Campo inválido", failure: .random(), isSecure: .random(), text: .constant("aa"))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
            .previewLayout(.sizeThatFits)
        }
    }
}
