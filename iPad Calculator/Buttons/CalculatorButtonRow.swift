//
//  CalculatorButtonRow.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct CalculatorButtonRow: View {
    var row: ButtonRowData
    @EnvironmentObject var sizes: ButtonModuleSize
    
    var padding: CGFloat { row.inset ? sizes.insetSize : 0 }
    var backgroundColor: Color { row.inset ? .gray.opacity(0.2) : .clear }
    
    var action: (String) -> Void
    
    var body: some View {
        HStack(spacing: sizes.buttonSpace + padding) {
            ForEach(row.buttons) {
                CalculatorButton(button: $0, action: action)
                    .environmentObject(ButtonModuleSize(buttonSize: sizes.buttonSize
                                                        - padding, buttonSpace: sizes.buttonSpace + 2 * padding, insetSize: sizes.insetSize, moduleSize: sizes.moduleSize))
            }
            .padding(padding / 2)
            .background(backgroundColor)
            .clipShape(Capsule()) // TODO: find out whether this is neccessary
        }
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    
    @StateObject static var sizes = ButtonModuleSize()
    static var previews: some View {
        CalculatorButtonRow(row: ButtonModuleData.numberBlock.rows[0]) { print($0) }
            .environmentObject(sizes)
    }
}
