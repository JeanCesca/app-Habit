//
//  HabitCardView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 17/02/23.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    let vm: HabitCardViewModel
    let isChart: Bool
    
    @State private var action = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            if isChart {
                NavigationLink(
                    destination: vm.chartView(),
                    isActive: $action) {
                    EmptyView()
                }
            } else {
                NavigationLink(
                    destination: vm.habitDetailView(),
                    isActive: $action) {
                    EmptyView()
                }
            }

            Button {
                action = true
            } label: {
                HStack {
                    ImageView(url: vm.icon)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(vm.name)
                                .foregroundColor(Color("buttonColor"))
                                .bold()
                                .fontWidth(.expanded)
                                .font(.footnote)
                            Text(vm.label)
                                .foregroundColor(Color("textColor"))
                                .fontWidth(.expanded)
                                .font(.footnote)
                            Text(vm.date)
                                .foregroundColor(Color("textColor"))
                                .fontWidth(.expanded)
                                .font(.footnote)
                                .fontWeight(.light)
                        }
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Registrado")
                                .foregroundColor(Color("buttonColor"))
                                .fontWidth(.expanded)
                                .bold()
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                            Text(vm.value)
                                .foregroundColor(Color("textColor"))
                                .fontWidth(.expanded)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer(minLength: 30)
                    }
                }
                .padding(10)
            }
            if !isChart {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 14, height: 14)
                    .padding(.trailing, 20)
                    .foregroundColor(vm.state)
            }
        }
        .background(
            BackgroundColor()
                .frame(maxWidth: .infinity)
                .cornerRadius(70)
        )
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            
            NavigationView {
                List {
                    HabitCardView(vm: HabitCardViewModel(
                        publisher: PassthroughSubject<Bool, Never>(), id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green), isChart: false)
                    HabitCardView(vm: HabitCardViewModel(
                        publisher: PassthroughSubject<Bool, Never>(), id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green), isChart: false)
                    HabitCardView(vm: HabitCardViewModel(
                        publisher: PassthroughSubject<Bool, Never>(), id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2023 00:00:00",
                        name: "Ouvir The Knife",
                        label: "horas",
                        value: "2",
                        state: .green), isChart: false)
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
