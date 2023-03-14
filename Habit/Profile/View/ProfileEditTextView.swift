//
//  ProfileEitTextView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct ProfileEditTextView: View {
    
    var placeholder: String = ""
    var mask: String? = ""
    var keyboard: UIKeyboardType = .default
    var autoCapitalization: TextInputAutocapitalization = .never
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .font(.headline)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocorrectionDisabled()
                .textInputAutocapitalization(autoCapitalization)
                .onChange(of: text) { newValue in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: newValue, text: &text)
                    }
                }
        }
    }
}

struct ProfileEitTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                ProfileEditTextView(
                    placeholder: "E-mail",
                    text: .constant(""))
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
            .previewLayout(.sizeThatFits)
        }
    }
}
