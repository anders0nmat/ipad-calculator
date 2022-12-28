//
//  Button.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct CalculatorButton: View {
    @Binding var button: ButtonData
    
    @EnvironmentObject var sizes: ButtonModuleSize
    
    var action: ((String) -> Void)!
    
    var body: some View {
        if !button.isEmpty {
            Button { action(button.command) } label: {
                Capsule()
                    .fill(button.color)
                    .overlay(alignment: .center) {
                        if button.icon == .none {
                            Label(button.name, systemImage: "")
                                .labelStyle(.titleOnly)
                                .padding(4)
                        }
                        else {
                            Label(button.name, systemImage: button.icon.rawIcon)
                                .labelStyle(.iconOnly)
                                .padding(4)
                        }
                    }
                    .foregroundColor(.primary)
            }
            .frame(width: sizes.totalWidth(Int(button.span)), height: sizes.buttonSize)
            .font(.system(size: 32, weight: .regular, design: .rounded))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        }
        else {
            Color.clear
                .frame(width: sizes.totalWidth(Int(button.span)), height: sizes.buttonSize)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    @StateObject static var sizes = ButtonModuleSize()
    static var previews: some View {
        CalculatorButton(button: .constant(.init(icon: .function, command: "", color: .action, span: 2))) { print($0) }
            .environmentObject(sizes)
    }
}
