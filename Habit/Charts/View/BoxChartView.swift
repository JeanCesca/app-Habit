//
//  BoxChartView.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 03/03/23.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> Charts.LineChartView {
        let view = LineChartView()
        view.backgroundColor = .tertiarySystemFill
        view.legend.enabled = false
        view.chartDescription.enabled = false
        view.xAxis.granularity = 1
        view.xAxis.labelPosition = .bottom
        view.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        view.rightAxis.enabled = false
        view.leftAxis.axisLineColor = .orange
        view.animate(yAxisDuration: 1.0)
        view.data = addData()
        return view
    }
    
    func updateUIView(_ uiView: Charts.LineChartView, context: Context) {
        
    }
    
    private func addData() -> LineChartData {
        
        let dataSet = LineChartDataSet(entries: entries, label: "label")
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.valueFont = .systemFont(ofSize: 10, weight: .light)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .orange
        
        return LineChartData(dataSet: dataSet)
    }
    
    typealias UIViewType = LineChartView
}

struct BoxChartView_Previews: PreviewProvider {
    static var previews: some View {
        BoxChartView(entries: .constant([
            ChartDataEntry(x: 0.0, y: 0.0),
            ChartDataEntry(x: 1.0, y: 1.0),
            ChartDataEntry(x: 2.0, y: 3.0),
            ChartDataEntry(x: 3.0, y: 1.0),
        ]), dates: .constant([
            "01/01/2021",
            "01/01/2021",
            "01/01/2021"
        ]))
        .frame(maxWidth: .infinity, maxHeight: 340)
    }
}

class DateAxisValueFormatter: AxisValueFormatter {
    
    private let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if position > 0 && position < dates.count {
            let date = dateFormatter.date(from: dates[position])
            
            guard let date = date else { return "" }
            
            let dF = DateFormatter()
            dF.dateFormat = "dd/MM"
            
            let createdAt = dF.string(from: date)
            return createdAt
        } else {
            return ""
        }
        
    }
}


