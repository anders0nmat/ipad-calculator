//
//  ButtonSettings.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 28.12.22.
//

import Foundation
import SwiftUI

struct ButtonSettings: View {
    
    @EnvironmentObject var sizes: ButtonModuleSize
    
    @Binding var selectedButton: ButtonData?
    @Binding var selectedRow: ButtonRowData
    
    init(for button: Binding<ButtonData?>, in row: Binding<ButtonRowData>?) {
        self._selectedButton = button
        self._selectedRow = row ?? .constant(.row())
    }
    
    var button: Binding<ButtonData> {
        Binding<ButtonData>($selectedButton) ?? .constant(.init(""))
    }
    
    var body: some View {
        Section("Button Settings") {
            Toggle("Empty Button", isOn: button.isEmpty)
        }
        .disabled(selectedButton == nil)
        .foregroundColor(selectedButton == nil ? .secondary : .primary)
        
        Section {
            Picker("Span", selection: button.span) {
                Text("1").tag(UInt(1))
                Text("2").tag(UInt(2))
                Text("3").tag(UInt(3))
                Text("4").tag(UInt(4))
            }
            .onChange(of: button.wrappedValue.span) { _ in
                withAnimation {
                    selectedRow.fitButtons(in: sizes.moduleSize.width)
                }
            }
        }
        .disabled(selectedButton == nil)
        .foregroundColor(selectedButton == nil ? .secondary : .primary)
        
        if button.wrappedValue.isEmpty == false {
            Section {
                TextField("Name", text: button.name)
                
                TextField("Command", text: button.enteredCommand, prompt: Text(button.wrappedValue.command))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                
                
                Menu {
                    Picker("Icon", selection: button.icon) {
                        ForEach(ButtonIcon.allCases) {
                            Label($0.rawValue, systemImage: $0 == .none ? "nosign" : $0.rawIcon)
                        }
                    }
                } label: {
                    HStack {
                        Text("Icon")
                        Spacer()
                        Image(systemName: (button.icon.wrappedValue) == .none ? "nosign" : button.icon.wrappedValue.rawIcon)
                        
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .scaleEffect(0.8, anchor: .center)
                    }
                }
                
                Menu {
                    Picker("Color", selection: button.btnColor) {
                        ForEach(ButtonColor.allCases) {
                            Text($0.rawValue)
                        }
                    }
                } label: {
                    HStack {
                        Text("Color")
                        Spacer()
                        RoundedRectangle(cornerRadius: 8)
                            .fill(button.wrappedValue.color)
                            .frame(maxWidth: 80)
                        
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.secondary)
                            .scaleEffect(0.8, anchor: .center)
                    }
                }
            }
            .disabled(selectedButton == nil)
            .foregroundColor(selectedButton == nil ? .secondary : .primary)
        }
    }
}
