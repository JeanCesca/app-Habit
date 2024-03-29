//
//  HomeView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 11/10/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            vm.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }
                .tag(0)
            
            vm.habitForChartView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }
                .tag(1)
            
            vm.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }
                .tag(2)
        }
        .tint(Color("buttonColor"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}
