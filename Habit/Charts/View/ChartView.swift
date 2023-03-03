//
//  ChartView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 02/03/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @StateObject var vm: ChartViewModel
    
    var body: some View {
        BoxChartView(entries: $vm.entries, dates: $vm.dates)
            .frame(maxWidth: .infinity, maxHeight: 300)
            .padding()
    } 
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartView(vm: ChartViewModel())
            ChartView(vm: ChartViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
