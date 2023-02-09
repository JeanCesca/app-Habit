//
//  TextField.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct SignTextField: View {
    
    @Binding var searchText: String
    let textFieldTitle: String
    
    var body: some View {
        TextField(textFieldTitle, text: $searchText)
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

struct SignTextField_Previews: PreviewProvider {
    static var previews: some View {
        SignTextField(searchText: .constant(""), textFieldTitle: "Olá")
            .previewLayout(.sizeThatFits)
    }
}
