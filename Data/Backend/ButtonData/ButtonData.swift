//
//  ButtonData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI

struct ButtonData: Identifiable, Hashable, ExpressibleByNilLiteral, Codable {
    var name: String
    var icon: ButtonIcon
    
    var command: String { enteredCommand.isEmpty ? name : enteredCommand }
    
    var enteredCommand: String
    var btnColor: ButtonColor
    var color: Color { btnColor.rawColor }
    var span: UInt = 1
    var isEmpty = false
    var id = UUID()
    
    init() {
        self.init(name: "", icon: .none, command: "", color: .default, span: 1)
        self.isEmpty = true
    }
    
    init(_ name: String, command: String = "", color: ButtonColor = .default, span: UInt = 1) {
        self.init(name: name, icon: .none, command: command, color: color, span: span)
    }
    
    init(icon: ButtonIcon, command: String, color: ButtonColor = .default, span: UInt = 1) {
        self.init(name: "", icon: icon, command: command, color: color, span: span)
    }
    
    mutating func shuffleId() {
        self.id = UUID()
    }
    
    
    init(nilLiteral: ()) { self.init() }
    
    private init(name: String, icon: ButtonIcon, command: String, color: ButtonColor, span: UInt) {
        self.name = name
        self.icon = icon
        self.enteredCommand = command
        self.btnColor = color
        self.span = max(1, span)
    }
}

enum ButtonColor: String, ColorSet, CaseIterable, Codable, Identifiable {
    case action = "Action"
    case number = "Number"
    case function = "Function"
    case altFunction = "Alt Function"
    case red = "Red"
    case green = "Green"
    case blue = "Blue"
    case yellow = "Yellow"
    
    case `default`
    
    var defaultColor: ButtonColor { .default }
    
    var id: Self { self }
    var rawColor: Color {
        switch self {
        case .default: return Self.function.rawColor
        case .action: return .orange
        case .number: return Color(uiColor: .systemGray4)
        case .function: return Color(uiColor: .systemGray5)
        case .altFunction: return Color(uiColor: .systemGray)
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        case .yellow: return .yellow
        }
    }
}

enum ButtonIcon: String, IconSet, CaseIterable, Codable, Identifiable {
    case none = "None"
    case plus_minus = "Plus/Minus"
    case divide = "Divide"
    case multiply = "Multiply"
    case minus = "Minus"
    case plus = "Plus"
    case equal = "Equal"
    case number = "Number"
    case function = "Function"
    case right_arrow = "Right Arrow"
    case sum = "Sum"
    case percent = "Percent"
    case root = "Root"
    
    var defaultIcon: ButtonIcon { .none }
    var rawIcon: String {
        switch self {
        case .none: return ""
        case .plus_minus: return "plus.forwardslash.minus"
        case .right_arrow: return "arrow.right"
        case .root: return "x.squareroot"
        default: return self.rawValue.lowercased()
        }
    }
    
    var id: ButtonIcon { self }
}

extension ButtonData {
    static func action(_ name: String, command: String = "", span: UInt = 1) -> ButtonData {
        ButtonData(name, command: command, color: .action, span: span)
    }
    
    static func action(icon: ButtonIcon, command: String, span: UInt = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .action, span: span)
    }
    
    static func number(_ name: String, command: String = "", span: UInt = 1) -> ButtonData {
        ButtonData(name, command: command, color: .number, span: span)
    }
    
    static func number(icon: ButtonIcon, command: String, span: UInt = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .number, span: span)
    }
    
    static func function(_ name: String, command: String = "", span: UInt = 1) -> ButtonData {
        ButtonData(name, command: command, color: .function, span: span)
    }
    
    static func function(icon: ButtonIcon, command: String, span: UInt = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .function, span: span)
    }
}
