//
//  Point.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 28.12.22.
//

import Foundation

struct Point<Value: Numeric>: Equatable {
    public var x: Value
    public var y: Value
    
    init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
    
    init(_ x: Value, _ y: Value) {
        self.init(x: x, y: y)
    }
    
    init(tuple: (Value, Value)) {
        self.init(x: tuple.0, y: tuple.1)
    }

    init(_ tuple: (Value, Value)) {
        self.init(tuple: tuple)
    }
}

typealias ArrayPoint = Point<Array.Index>
