//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 09/02/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: (() -> Void)
    var text: String
    var showProgressBar: Bool = false
    var disabled: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: action) {
                Text(
                    showProgressBar ? "": text
                )
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .fontWidth(.expanded)
                    .background(
                        disabled ? Color("buttonColor").opacity(0.5) : Color("buttonColor")
                    )
                    .cornerRadius(20)
            }
            .disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(
                    showProgressBar ? 1 : 0
                )
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingButtonView(action: {
                print("🐸")
            },text: "Entrar", showProgressBar: false, disabled: true)
            .preferredColorScheme(.light)
            LoadingButtonView(action: {
                print("🐸")
            }, text: "Entrar")
            .preferredColorScheme(.dark)
        }
    }
}
