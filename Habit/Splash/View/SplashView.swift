//
//  SplashView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 10/10/22.
//

import Foundation
import SwiftUI

struct SplashView: View {
        
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Carregar tela home")
            case .error(let errorMessage):
                loadingView(error: errorMessage)
    //            Text("Mostrar erro \(errorMessage)")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

//Funções em extensões
extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ZStack {
                Image("doglogin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }

            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            //faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

//Variáveis em extensões
extension SplashView {
    var loading: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            ZStack {
                Image("doglogin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
            
    }
}

//Compartilhamento de objetos
struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Image("dog")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: .infinity, height: .infinity, alignment: .center)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}


