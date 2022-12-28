//
//  CalculatorButtonModule.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct CalculatorButtonModule: View {
    @Binding var module: ButtonModuleData
    @EnvironmentObject var sizes: ButtonModuleSize
    var action: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: sizes.buttonSpace) {
                ForEach($module.rows, id: \.self) {
                    CalculatorButtonRow(row: $0, action: action)
                }
            }
            Spacer(minLength: 0)
        }
        .frame(width: sizes.moduleWidth, height: sizes.moduleHeight)
    }
}

struct CalculatorButtonModule_Previews: PreviewProvider {
    
    @StateObject static var sizes = ButtonModuleSize()
    static var previews: some View {
        CalculatorButtonModule(module: .constant(.numberBlock)) { print($0) }
            .environmentObject(sizes)
    }
}
