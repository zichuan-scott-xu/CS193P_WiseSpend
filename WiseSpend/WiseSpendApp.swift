//
//  WiseSpendApp.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

@main
struct WiseSpendApp: App {
    
    @StateObject var spendingHistoryStore = SpendingHistory(named: "Default")
    @StateObject var userSettingStore = UserSettingViewModel(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            WiseSpendMainView()
                .environmentObject(spendingHistoryStore)
                .environmentObject(userSettingStore)
        }
    }
}
