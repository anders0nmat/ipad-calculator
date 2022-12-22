//
//  ButtonArea.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct ButtonArea: View {
    var modules: [ButtonModuleData]
    var availableSpace: CGFloat
    
    @EnvironmentObject var sizes: ButtonModuleSize
    
    var action: (String) -> Void
    
    private func tabs(start index: Array.Index) -> some View {
        ButtonTab(modules[index...].map{ .init($0, icon: $0.icon.rawValue) }) {
            CalculatorButtonModule(module: $0, action: action)
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0.5 * sizes.buttonSpace) {
            if modules.count == 1 {
                CalculatorButtonModule(module: modules[0], action: action)
            }
            else if availableSpace < 2 * sizes.moduleWidth {
                // all in tabs
                tabs(start: 0)
            }
            else if modules.count == 2 || availableSpace < 3 * sizes.moduleWidth {
                // one tab and one fixed
                tabs(start: 1)
                Divider()
                    .frame(height: sizes.moduleHeight)
                CalculatorButtonModule(module: modules.first!, action: action)
            }
            else {
                // two tabs and a fixed module
                tabs(start: 1)
                Divider()
                    .frame(height: sizes.moduleHeight)
                tabs(start: 1)
                Divider()
                    .frame(height: sizes.moduleHeight)
                CalculatorButtonModule(module: modules.first!, action: action)
            }
        }
    }
}
