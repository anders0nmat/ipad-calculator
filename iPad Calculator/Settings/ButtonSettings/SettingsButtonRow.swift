//
//  SettingsButtonRow.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import SwiftUI

struct SettingsButtonRow: View {
    @Binding var row: ButtonRowData
    @EnvironmentObject var sizes: ButtonModuleSize
    
    var padding: CGFloat { row.inset ? sizes.insetSize : 0 }
    var backgroundColor: Color { row.inset ? .gray.opacity(0.2) : .clear }
    
    var yCoord: Array.Index
    @Binding var selectedPoint: ArrayPoint?
    
    var isSelected: Bool {
        selectedPoint?.y == yCoord
    }
    
    var body: some View {
        HStack(spacing: sizes.buttonSpace + padding) {
            ForEach(row.fittingButtonIndices(in: sizes.moduleSize.width), id: \.self) { index in
                SettingsButton(button: $row.buttons[index], point: ArrayPoint(x: index, y: yCoord), selectedPoint: $selectedPoint)
                .environmentObject(ButtonModuleSize(buttonSize: sizes.buttonSize
                                                    - padding, buttonSpace: sizes.buttonSpace + 2 * padding, insetSize: sizes.insetSize, moduleSize: sizes.moduleSize))
            }
        }
        .padding(padding / 2)
        .background(RoundedRectangle(cornerRadius: isSelected ? 8 : sizes.buttonSize / 2)
            .fill(backgroundColor))
    }
}

fileprivate struct PreviewContainer: View {
    @State var selected: ArrayPoint?
    @State var row: ButtonRowData = .inset(.init(icon: .equal, command: "helais"), .init(icon: .minus, command: "home", color: .action))
    var body: some View {
        VStack {
            SettingsButtonRow(row: $row, yCoord: 3, selectedPoint: $selected.animation(.easeInOut(duration: 0.2)))
            Text(String(describing: selected))
        }
    }
}

struct SettingsButtonRow_Previews: PreviewProvider {
    @StateObject static var sizes = ButtonModuleSize()
    static var previews: some View {
        PreviewContainer()
            .environmentObject(sizes)
    }
}
