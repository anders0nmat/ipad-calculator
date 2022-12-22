//
//  ButtonData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI

struct ButtonData: Identifiable, Hashable, ExpressibleByNilLiteral {
    var name: String
    var icon: String
    
    var command: String
    private var btnColor: ButtonColor
    var color: Color { btnColor.rawValue }
    var span: Int = 1
    var isEmpty = false
    var id = UUID()
    
    init() {
        self.init(name: "", icon: "", command: "", color: .default, span: 1)
        self.isEmpty = true
    }
    
    init(_ name: String, command: String? = nil, color: ButtonColor = .default, span: Int = 1) {
        self.init(name: name, icon: "", command: command ?? name, color: color, span: span)
    }
    
    init(icon: String, command: String, color: ButtonColor = .default, span: Int = 1) {
        self.init(name: "", icon: icon, command: command, color: color, span: span)
    }
    
    
    init(nilLiteral: ()) { self.init() }
    
    private init(name: String, icon: String, command: String, color: ButtonColor, span: Int) {
        self.name = name
        self.icon = icon
        self.command = command
        self.btnColor = color
        self.span = max(1, span)
    }
}

enum ButtonColor: CaseIterable {
    case action
    case number
    case function
    case altFunction
    
    case `default`
    var rawValue: Color {
        switch self {
        case .default: return Self.function.rawValue
        case .action: return .orange
        case .number: return Color(uiColor: .secondarySystemBackground)
        case .function: return Color(uiColor: .tertiarySystemBackground)
        case .altFunction: return .gray
        }
    }
}

extension ButtonData {
    static func action(_ name: String, command: String? = nil, span: Int = 1) -> ButtonData {
        ButtonData(name, command: command, color: .action, span: span)
    }
    
    static func action(icon: String, command: String, span: Int = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .action, span: span)
    }
    
    static func number(_ name: String, command: String? = nil, span: Int = 1) -> ButtonData {
        ButtonData(name, command: command, color: .number, span: span)
    }
    
    static func number(icon: String, command: String, span: Int = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .number, span: span)
    }
    
    static func function(_ name: String, command: String? = nil, span: Int = 1) -> ButtonData {
        ButtonData(name, command: command, color: .function, span: span)
    }
    
    static func function(icon: String, command: String, span: Int = 1) -> ButtonData {
        ButtonData(icon: icon, command: command, color: .function, span: span)
    }
}
