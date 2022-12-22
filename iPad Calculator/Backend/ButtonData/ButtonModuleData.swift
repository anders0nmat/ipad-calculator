//
//  ButtonModuleData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation

struct ButtonModuleData: Hashable {
    var name: String
    var icon: ModuleIcon
    var rows: [ButtonRowData]
    
    init(name: String = "", icon: ModuleIcon = .buttons2x2, _ rows: [ButtonRowData]) {
        self.name = name
        self.icon = icon
        self.rows = rows
    }
}

enum ModuleIcon: String, CaseIterable {
    case buttons2x2 = "circle.grid.2x2"
    case number = "number"
}

extension ButtonModuleData {
    static let numberBlock = ButtonModuleData(name: "Basic Algebra", icon: .number, [
        .row(
            .init("AC", color: .altFunction),
            .init(icon: "plus.forwardslash.minus", command: "+-", color: .altFunction),
            .init("%", color: .altFunction),
            .action(icon: "divide", command: "/")
        ),
        .row( .number("7"), .number("8"), .number("9"), .action(icon: "multiply", command: "*") ),
        .row( .number("4"), .number("5"), .number("6"), .action(icon: "minus", command: "-") ),
        .row( .number("1"), .number("2"), .number("3"), .action(icon: "plus", command: "+") ),
        .row( .number("0", span: 2),      .number("."), .action(icon: "equal", command: "=") )
    ])
    
    static let basicFunctions = ButtonModuleData([
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
            nil,
            nil,
            nil,
            .action(icon: "arrow.right", command: "->")
        ),
    ])
}
