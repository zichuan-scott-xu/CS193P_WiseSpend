//
//  WiseSpendMainView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

struct WiseSpendMainView: View {
    var body: some View {
        // API: TabView
        TabView {
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Stats")
                }
            BudgetView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Budget")
                }
                .padding(.bottom)
            MemoryView()
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Memory")
                }
        }
        .accentColor(.pink)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WiseSpendMainView()
    }
}
