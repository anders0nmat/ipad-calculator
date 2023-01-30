//
//  ButtonModuleData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation

struct ButtonModuleData: Identifiable, Hashable, Codable {
    var name: String
    var icon: ModuleIcon
    var rows: [ButtonRowData]
    var id = UUID()
    
    init(name: String = "Generic Module", icon: ModuleIcon = .buttons2x2, _ rows: [ButtonRowData]) {
        self.name = name
        self.icon = icon
        self.rows = rows
    }
    
    mutating func shuffleId() {
        self.id = UUID()
        for idx in rows.indices {
            rows[idx].shuffleId()
        }
    }
}

enum ModuleIcon: String, CaseIterable, Codable {
    case buttons2x2 = "Four Circles"
    case number = "Number"
    case rectangle3x2 = "Rectangle Grid"
    case angle = "Angle"
    case square = "Square"
    
    var rawIcon: String {
        switch self {
        case .buttons2x2: return "circle.grid.2x2"
        case .rectangle3x2: return "rectangle.grid.3x2"
        
        default: return self.rawValue.lowercased()
        }
    }
}

extension ButtonModuleData {
    static let numberBlock = Self.init(name: "Basic Algebra", icon: .number, [
        .row(
            .init("AC", color: .altFunction),
            .init(icon: .plus_minus, command: "+-", color: .altFunction),
            .init("%", color: .altFunction),
            .action(icon: .divide, command: "/")
        ),
        .row( .number("7"), .number("8"), .number("9"), .action(icon: .multiply, command: "*") ),
        .row( .number("4"), .number("5"), .number("6"), .action(icon: .minus, command: "-") ),
        .row( .number("1"), .number("2"), .number("3"), .action(icon: .plus, command: "+") ),
        .row( .number("0", span: 2),      .number("."), .action(icon: .equal, command: "="), nil )
    ])
    
    static let basicFunctions = Self.init(name: "Basic Functions", [
        .row(
            .function("()"),
            .function("|x|", command: "abs"),
            .function("pi"),
            .function("log10")
        ),
        .row(
            .function("x^2", command: "sqr"),
            .function("x^3", command: "cbe"),
            .function("x^y", command: "^"),
            .function("e^x", command: "exp")
        ),
        .row(
            .function("sqrt(x)", command: "sqrt"),
            .function("cbrt(x)", command: "cbrt"),
            .function("yroot(x)", command: "yroot"),
            .function("ln", command: "ln")
        ),
        .row(
            .function("sin"),
            .function("cos"),
            .function("tan"),
            .function("e")
        ),
        .row(
            .function("Ans", command: "#var:ans"),
            nil,
            nil,
            .action(icon: .right_arrow, command: "->")
        ),
    ])
    
    static let empty = Self.init(name: "Empty Module", icon: .square, [
        .row(nil, nil, nil, nil),
        .row(nil, nil, nil, nil),
        .row(nil, nil, nil, nil),
        .row(nil, nil, nil, nil),
        .row(nil, nil, nil, nil),
    ])
        
    
    static let templates: [ButtonModuleData] = [
        .empty,
        .numberBlock,
        .basicFunctions,
    ]
}
