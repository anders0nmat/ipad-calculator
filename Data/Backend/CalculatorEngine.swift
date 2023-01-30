//
//  CalculatorEngine.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftMathParser

class CalculatorEngine: ObservableObject {
    @Published var history: [CalculatorEntry]
    var currEntry: Array.Index
    
    @Published var variables: [String: Double]
    @Published var variableOrder: [String]
    
    var insertPoint: AnyObject? {
        history.indices ~= currEntry ? history[currEntry].parser.insertionPoint : nil
    }
    
    init() {
        self.history = [CalculatorEntry()]
        self.currEntry = 0
        self.variables = [:]
        self.variableOrder = []
    }
    
    func processCommand(_ command: String) {
        // TODO: Also handle Adding/Deleting Entries
        if command == "=" {
            newParser()
            currEntry = history.endIndex - 1
        }
        else if history.indices ~= currEntry {
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
        let lastIndex = history.endIndex - 1
        history.last!.parser.expression.setVariableLookup { [weak self](name) -> ExpressionResult? in
            guard let self = self else { return nil }
            
            if name.hasPrefix("r") {
                if let idx = Int(name.suffix(from: name.index(name.startIndex, offsetBy: 1))), self.history.indices ~= idx {
                    return try? self.history[idx].parser.expression.evaluate()
                }
            }
            
            if name == "ans" && lastIndex > 0 {
                return try? self.history[lastIndex - 1].parser.expression.evaluate()
            }
            
            if let variableValue = self.variables[name] {
                return .number(variableValue)
            }
            
            return nil
        }
        currEntry = history.endIndex - 1
    }
    
    func addOrSetVariable(name: String, value: Double) {
        if !self.variables.keys.contains(name) {
            self.variableOrder.append(name)
        }
        self.variables[name] = value
    }
}
