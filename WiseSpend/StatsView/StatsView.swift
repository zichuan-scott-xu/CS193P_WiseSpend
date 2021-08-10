//
//  StatsView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/28.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var spendingHistoryStore: SpendingHistory
    
    @State var selectedYear = Date().getCurrentYear()
    @State var selectedMonth = Date().getCurrentMonth()
    @State var showMonthYearPicker = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Stats by category")
                    .fontWeight(.bold)
                    .font(.title)
            }
            HStack {
                Button(action: {
                    showMonthYearPicker = true
                }, label: {
                    Image(systemName: "calendar").font(.title)
                })
                .popover(isPresented: $showMonthYearPicker) {
                    GeometryReader { geometry in
                        MonthYearPicker(selectedYear: $selectedYear, selectedMonth: $selectedMonth, geometry: geometry)
                    }
                }
                .padding()
                Text(Date.monthYearToString(month: selectedMonth, year: selectedYear))
            }
            .padding(.bottom)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(
                            spendingHistoryStore.getCategoryStats(month: selectedMonth, year: selectedYear).sorted(by: {$0.1 > $1.1}),
                            id: \.self.0) { key in
                            Text(key.0)
                            BarView(key.1/spendingHistoryStore.getSumSpending(month: selectedMonth, year: selectedYear),
                                    in: geometry,
                                    spending: String(key.1))
                                .animation(.easeInOut(duration: 1.5))
                        }
                        
                    }
                    .padding(.horizontal, geometry.size.width * 0.15)
                }
            }
        }
        .frame(alignment: .center)
        .padding(.vertical)
    }
    
    
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
