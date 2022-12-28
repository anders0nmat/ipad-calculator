//
//  ObjectAppStorage.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import Foundation
import SwiftUI

@propertyWrapper
struct ObjectAppStorage<Value: Codable> {
    private var storage: AppStorage<Data>
    private var fallbackValue: Value
    
    var wrappedValue: Value {
        get {
            (try? JSONDecoder().decode(Value.self, from: storage.wrappedValue)) ?? fallbackValue
        }
        nonmutating set {
            storage.wrappedValue = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    var projectedValue: Binding<Value> { Binding(get: { self.wrappedValue }, set: { self.wrappedValue = $0 }) }
    
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.fallbackValue = wrappedValue
        self.storage = AppStorage(wrappedValue: Data(), key, store: store)
    }
}

