//
//  HabitCardView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import SwiftUI

struct HabitCardView: View {
    
    let vm: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink("") {
                EmptyView()
            }
            
            Button {
                //
            } label: {
                HStack {
                    Image(systemName: "pencil")
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(vm.name)
                                .foregroundColor(Color("buttonColor"))
                                .bold()
                            Text(vm.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            Text(vm.date)
                                .foregroundColor(Color("textColor"))
                                .fontWeight(.light)
                        }
                        .frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Registrado")
                                .foregroundColor(Color("buttonColor"))
                            Text(vm.value)
                                .foregroundColor(Color("textColor"))
                        }
                        .bold()
                        .multilineTextAlignment(.leading)
                        
                        Spacer(minLength: 30)
                    }
                    Rectangle()
                        .frame(width: 12)
                        .foregroundColor(vm.state)
                }
//                .padding(10)
                .background(
                    Color.red.opacity(0.03)
                )
                .cornerRadius(20)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.orange.opacity(0.6), lineWidth: 1.4)
        )
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            
            NavigationView {
                List {
                    HabitCardView(vm: HabitCardViewModel(
                        id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green))
                    HabitCardView(vm: HabitCardViewModel(
                        id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green))
                    HabitCardView(vm: HabitCardViewModel(
                        id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green))
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("Lista")
                .listStyle(.plain)
            }
            .preferredColorScheme($0)
            .previewLayout(.sizeThatFits)
        }
    }
}
