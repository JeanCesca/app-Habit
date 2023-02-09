//
//  SaveButton2.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct SaveButton: View {
    var text: String
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        
        Button(action: clicked) {
            Text(text)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 20)
        .foregroundColor(Color("buttonText"))
        .padding()
        .background(Color("buttonColor"))
        .cornerRadius(20)
        .padding(.top, 16)
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton(text: "Realize seu cadastro") {
            print("Clicou")
        }
    }
}
