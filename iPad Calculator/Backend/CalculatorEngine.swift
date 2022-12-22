//
//  CalculatorEngine.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation

class CalculatorEngine: ObservableObject {
    @Published var history: [CalculatorEntry]
    var currEntry: Array.Index
    
    var insertPoint: AnyObject? {
        history.indices ~= currEntry ? history[currEntry].parser.insertionPoint : nil
    }
    
    init() {
        self.history = [CalculatorEntry()]
        self.currEntry = 0
    }
    
    func processCommand(_ command: String) {
        // TODO: Also handle Adding/Deleting Entries
        if history.indices ~= currEntry {
            do {
                try history[currEntry].parser.parse(command)
            }
            catch {
                print(error)
            }
        }
    }
    
    func newParser() {
        history.append(CalculatorEntry())
        currEntry = history.endIndex - 1
    }
}
