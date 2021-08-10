//
//  SpendEvent.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import Foundation

struct SpendEvent : Identifiable, Codable, Hashable {
    var name: String
    var date: Date
    var spending: Double
    var category: String
    var isMemory: Bool
    var lattitude: Double?
    var longitude: Double?
    var location: String?
    var id: Int
}
