//
//  SpendingHistory.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/25.
//

import Foundation

class SpendingHistory: ObservableObject {
    let name: String
    
    @Published var events = [SpendEvent]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    
    init(named name: String) {
        self.name = name
        if events.isEmpty {
            addDefaultEvents()
        } else {
            restoreFromUserDefaults()
        }
    }
    
    
    // MARK: - Intents
    func addSpendingEvent(named name: String, date: Date, spending: Double, category: String = "Default", isMemory: Bool = false, at index: Int = 0) {
        let unique = (events.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let newEvent = SpendEvent(name: name, date: date, spending: spending, category: category, isMemory: isMemory, id: unique)
        let safeIndex = min(max(index, 0), events.count)
        events.insert(newEvent, at: safeIndex)
    }
    
    @discardableResult
    func removeSpendingEvent(at index: Int) -> Int {
        if events.count > 1, events.indices.contains(index) {
            events.remove(at: index)
        }
        return index % events.count
    }
    
    func event(at index: Int) -> SpendEvent {
        let safeIndex = min(max(index, 0), events.count - 1)
        return events[safeIndex]
    }
    
    func getSumSpending(month: Int, year: Int) -> Double {
        var sum: Double = 0
        
        for event in events {
            let calendarDate = Calendar.current.dateComponents([.day, .month, .year], from: event.date)
            if calendarDate.month == month && calendarDate.year == year {
                sum += event.spending
            }
        }
        return sum
    }
    
    func getCategoryStats(month: Int, year: Int) -> [String: Double] {
        var stats = Dictionary<String, Double>()
        
        for event in events {
            let calendarDate = Calendar.current.dateComponents([.day, .month, .year], from: event.date)
            if calendarDate.month == month && calendarDate.year == year {
                var key = "uncategorized"
                if event.category != "" {
                    key = event.category
                }
                if stats[key] != nil {
                    stats[key]! += event.spending
                } else {
                    stats[key] = event.spending
                }
            }
        }
        return stats
    }
    
    func allMemories() -> [SpendEvent] {
        return events.filter {
            $0.isMemory == true
        }
    }

    // MARK: - Storing in UserDefaults
    
    private var userDefaultsKey: String {
        "UserDefault:" + "SpendingHistory:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(events), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedEvents = try? JSONDecoder().decode(Array<SpendEvent>.self, from: jsonData) {
            events = decodedEvents
        }
    }
    
    
    // MARK: - Add Default events
    func addDefaultEvents() {
        
        addSpendingEvent(named: "IOS Dev Book", date: Date.from(year: 2021, month: 6, day: 6),
                         spending: 99.92, category: "Study")
        addSpendingEvent(named: "Flower", date: Date.from(year: 2021, month: 6, day: 13),
                         spending: 105, category: "Gift", isMemory: true)
        addSpendingEvent(named: "Cooking guide", date: Date.from(year: 2021, month: 6, day: 31),
                         spending: 75, category: "Food")
        addSpendingEvent(named: "Steakhouse", date: Date.from(year: 2021, month: 6, day: 17),
                         spending: 40, category: "Food", isMemory: true)
        addSpendingEvent(named: "C++ Program", date: Date.from(year: 2021, month: 5, day: 7),
                         spending: 125, category: "Study")
        addSpendingEvent(named: "BBQ Party", date: Date.from(year: 2021, month: 5, day: 14),
                         spending: 300, category: "Food")
        addSpendingEvent(named: "Spicy Ramen", date: Date.from(year: 2021, month: 5, day: 1),
                         spending: 15, category: "Food")
        addSpendingEvent(named: "Karen's gift", date: Date.from(year: 2021, month: 5, day: 14), spending: 520, category: "Gift")
        addSpendingEvent(named: "Scott's gift", date: Date.from(year: 2021, month: 5, day: 20),
                         spending: 350, category: "Gift", isMemory: true)
    }
}
