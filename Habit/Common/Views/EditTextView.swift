//
//  EditTextView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct EditTextView: View {
    
    var placeholder: String = ""
    var mask: String? = ""
    var error: String? = nil
    var failure: Bool = false
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false
    var autoCapitalization: TextInputAutocapitalization = .never
    
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
                    .textInputAutocapitalization(autoCapitalization)
            } else {
                TextField(placeholder, text: $text)
                    .font(.headline)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocorrectionDisabled()
                    .textFieldStyle(CustomTextFieldStyle())
                    .textInputAutocapitalization(autoCapitalization)
                    .onChange(of: text) { newValue in
                        if let mask = mask {
                            //###.###.###-## to 123.123.123-12
                            Mask.mask(mask: mask, value: newValue, text: &text)
                        }
                    }
            }
            
            if let error = error, failure == true, !text.isEmpty {
                ZStack {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(Color("buttonColor").opacity(0.5))
                }
            }
        }
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(placeholder: "E-mail", error: "Campo inválido", failure: .random(), isSecure: .random(), text: .constant(""))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
            .previewLayout(.sizeThatFits)
        }
    }
}
