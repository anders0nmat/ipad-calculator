//
//  SettingsButtonModule.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import SwiftUI

struct SettingsButtonModule: View {
    @Binding var module: ButtonModuleData
    @EnvironmentObject var sizes: ButtonModuleSize
    
    @Binding var selectedPoint: ArrayPoint?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: sizes.buttonSpace) {
                ForEach(Array($module.rows.enumerated()), id: \.element.wrappedValue.self) { index, $data in
                    SettingsButtonRow(row: $data, yCoord: index, selectedPoint: $selectedPoint)
                }
            }
            Spacer(minLength: 0)
        }
        .frame(width: sizes.moduleWidth, height: sizes.moduleHeight)
    }
}

fileprivate struct PreviewContainer: View {
    @State var module: ButtonModuleData = .numberBlock
    @State var selected: ArrayPoint?
    var body: some View {
        VStack {
            SettingsButtonModule(module: $module, selectedPoint: $selected.animation(.easeInOut(duration: 0.2)))
            
            Text(String(describing: selected))
        }
    }
}

struct SettingsButtonModule_Previews: PreviewProvider {
    @State static var module: ButtonModuleData = .numberBlock
    @State static var selected: ArrayPoint?
    @StateObject static var sizes = ButtonModuleSize()
    static var previews: some View {
        PreviewContainer()
            .environmentObject(sizes)
    }
}
