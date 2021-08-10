//
//  UserSetting.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/28.
//

import SwiftUI


struct UserSetting: Codable {
    // Stores the monthly budget of the user: {[Month, Year] : (Budget)}
    var budgets: Dictionary<[Int], Double>
    
    init() {
        self.budgets = Dictionary()
    }
}


class UserSettingViewModel: ObservableObject {
    
    let name: String
    
    @Published var userSetting: UserSetting {
        didSet {
            storeInUserDefaults()
        }
    }
    
    init(named name: String) {
        self.name = name
        self.userSetting = UserSetting()
        restoreFromUserDefaults()
//        if true {
        if userSetting.budgets.isEmpty {
            updateBudget(month: 5, year: 2002, budget: 520)
        }
    }
    
    
    // MARK: - UserDefaults
    
    private var userDefaultsKey: String {
        "UserDefault:" + "userSetting:" + name
    }
    

    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(userSetting), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedUserSetting = try? JSONDecoder().decode(UserSetting.self, from: jsonData) {
            userSetting = decodedUserSetting
        }
    }
    
    // MARK: - Intents of Budgets
    
    func updateBudget(month: Int, year: Int, budget: Double) {
        userSetting.budgets[[month, year]] = budget
    }
    
    func removeBudget(month: Int, year: Int) {
        userSetting.budgets.removeValue(forKey: [month, year])
    }
    
    func getBudget(month: Int, year: Int) -> Double? {
        return userSetting.budgets[[month, year]] // return nil if not present
    }
    
}
