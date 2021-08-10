//
//  Extensions.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/25.
//

import Foundation


// MARK: - Date extension for easily creating dates

extension Date {
    /// Create a date from specified parameters
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    static func from(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
    
    func printDate(showDay: Bool) -> String {
        let calendarDate = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let year = calendarDate.year!
        let month = calendarDate.month!
        let day = calendarDate.day!
        let monthMap = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        if showDay {
            return ("\(String(monthMap[month - 1])) \(String(day)), \(year)")
        } else {
            return ("\(String(monthMap[month - 1])), \(year)")
        }
    }
    
    static func monthYearToString(month: Int, year: Int) -> String {
        let monthMap = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return "\(monthMap[month - 1]), \(String(year))"
    }
    
    func getCurrentYear() -> Int {
        let calendarDate = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return calendarDate.year!
    }
    
    func getCurrentMonth() -> Int {
        let calendarDate = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return calendarDate.month!
    }
}

// MARK: - Container Extensions (borrowed from CS193P demo code)

// in a Collection of Identifiables
// we often might want to find the element that has the same id
// as an Identifiable we already have in hand
// we name this index(matching:) instead of firstIndex(matching:)
// because we assume that someone creating a Collection of Identifiable
// is usually going to have only one of each Identifiable thing in there
// (though there's nothing to restrict them from doing so; it's just a naming choice)

extension Collection where Element: Identifiable {
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}

// we could do the same thing when it comes to removing an element
// but we have to add that to a different protocol
// because Collection works for immutable collections of things
// the "mutable" one is RangeReplaceableCollection
// not only could we add remove
// but we could add a subscript which takes a copy of one of the elements
// and uses its Identifiable-ness to subscript into the Collection
// this is an awesome way to create Bindings into an Array in a ViewModel
// (since any Published var in an ObservableObject can be bound to via $)
// (even vars on that Published var or subscripts on that var)
// (or subscripts on vars on that var, etc.)

extension RangeReplaceableCollection where Element: Identifiable {
    mutating func remove(_ element: Element) {
        if let index = index(matching: element) {
            remove(at: index)
        }
    }

    subscript(_ element: Element) -> Element {
        get {
            if let index = index(matching: element) {
                return self[index]
            } else {
                return element
            }
        }
        set {
            if let index = index(matching: element) {
                replaceSubrange(index...index, with: [newValue])
            }
        }
    }
}

// convenience functions for [NSItemProvider] (i.e. array of NSItemProvider)
// makes the code for  loading objects from the providers a bit simpler
// NSItemProvider is a holdover from the Objective-C (i.e. pre-Swift) world
// you can tell by its very name (starts with NS)
// so unfortunately, dealing with this API is a little bit crufty
// thus I recommend you just accept that these loadObjects functions will work and move on
// it's a rare case where trying to dive in and understand what's going on here
// would probably not be a very efficient use of your time
// (though I'm certainly not going to say you shouldn't!)
// (just trying to help you optimize your valuable time this quarter)

extension Array where Element == NSItemProvider {
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        if let provider = first(where: { $0.canLoadObject(ofClass: theType) }) {
            provider.loadObject(ofClass: theType) { object, error in
                if let value = object as? T {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading {
        if let provider = first(where: { $0.canLoadObject(ofClass: theType) }) {
            let _ = provider.loadObject(ofClass: theType) { object, error in
                if let value = object {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
    func loadFirstObject<T>(ofType theType: T.Type, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        loadObjects(ofType: theType, firstOnly: true, using: load)
    }
    func loadFirstObject<T>(ofType theType: T.Type, using load: @escaping (T) -> Void) -> Bool where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading {
        loadObjects(ofType: theType, firstOnly: true, using: load)
    }
}
