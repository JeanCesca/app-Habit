//
//  GenderSelectorView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 01/03/23.
//

import SwiftUI

struct GenderSelectorView: View {
    
    let title: String
    let genders: [Gender]
    
    @Binding var selectedGender: Gender?
    
    var body: some View {
        Form {
            Section {
                List(genders, id: \.self) { gender in
                    
                    HStack {
                        Text(gender.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(
                                selectedGender == gender ? Color("buttonColor") : .white
                            )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == gender) {
                            selectedGender = gender
                        }
                    }
                }
            } header: {
                Text(title)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(title: "Gênero", genders: Gender.allCases, selectedGender: .constant(.cisMale))
    }
}
