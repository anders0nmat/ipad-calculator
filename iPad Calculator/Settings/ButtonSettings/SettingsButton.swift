//
//  SettingsButton.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import SwiftUI

struct SettingsButton: View {
    @Binding var button: ButtonData
    
    @EnvironmentObject var sizes: ButtonModuleSize

    var point: ArrayPoint
    @Binding var selectedPoint: ArrayPoint?
    
    var isSelected: Bool { selectedPoint == point }
    
    var body: some View {
        if !button.isEmpty {
            Button {
                self.selectedPoint = isSelected ? nil : point
                print("State changed to \(String(describing: selectedPoint))")
            } label: {
                RoundedRectangle(cornerRadius: isSelected ? 8 : sizes.buttonSize / 2)
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
            Button {
                selectedPoint = isSelected ? nil : point
            } label: {
                /*Checkerboard(size: 4)
                    .fill(.gray.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: isSelected ? 8 : sizes.buttonSize / 2))
                 */
                RoundedRectangle(cornerRadius: isSelected ? 8 : sizes.buttonSize / 2)
                    .stroke(.gray.opacity(0.2), lineWidth: 2)                    
            }
            .frame(width: sizes.totalWidth(Int(button.span)), height: sizes.buttonSize)
        }
    }
}

fileprivate struct PreviewContainer: View {
    @State var selected: ArrayPoint?
    @State var data: ButtonData = .init(icon: .number, command: "home", color: .action, span: 1)
    var body: some View {
        VStack {
            SettingsButton(button: $data, point: ArrayPoint(4, 4), selectedPoint: $selected.animation(.easeInOut(duration: 0.2)))
                
            
            Button("Set") {
                print("state changed")
                selected?.x = 7
            }
            
            Text(String(describing: selected))
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    @StateObject static var sizes = ButtonModuleSize()
    @State static var selected: ArrayPoint? = nil
    
    static var previews: some View {
        PreviewContainer()
            .environmentObject(sizes)
    }
}
