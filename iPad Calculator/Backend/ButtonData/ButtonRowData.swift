//
//  ButtonRowData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation

struct ButtonRowData: Hashable {
    var buttons: [ButtonData]
    var inset: Bool = false
}

extension ButtonRowData {
    static func row(_ buttons: ButtonData...) -> ButtonRowData {
        ButtonRowData(buttons: buttons)
    }
    
    static func inset(_ buttons: ButtonData...) -> ButtonRowData {
        ButtonRowData(buttons: buttons, inset: true)
    }
}
