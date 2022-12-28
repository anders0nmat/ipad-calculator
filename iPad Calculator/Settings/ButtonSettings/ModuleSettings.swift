//
//  ButtonSettings.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import SwiftUI

struct ModuleSettings: View {
    
    @EnvironmentObject var configuration: ButtonConfiguration
    @EnvironmentObject var sizes: ButtonModuleSize
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectedCoords: ArrayPoint?
    
    @Binding var originalModule: ButtonModuleData
    @State var selectedModule: ButtonModuleData
    
    init(for module: Binding<ButtonModuleData>) {
        self._originalModule = module
        
        // Copy original for dismissing changes
        self._selectedModule = State(wrappedValue: module.wrappedValue)
    }
    
    var selectedRow: Binding<ButtonRowData>? { selectedCoords != nil ? $selectedModule.rows[selectedCoords!.y] : nil }

    // Force unwrap selectedCoords because selectedRow would return nil if it is unsafe
    var selectedButton: Binding<ButtonData?> { Binding<ButtonData?>(selectedRow?.buttons[selectedCoords!.x] ?? .constant(nil)) }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section("Module Settings") {
                    TextField("Name", text: $selectedModule.name)
                    
                    Picker("Icon", selection: $selectedModule.icon) {
                        ForEach(ModuleIcon.allCases, id: \.self) {
                            Label($0.rawValue, systemImage: $0.rawIcon)
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                
                ButtonSettings(for: selectedButton, in: selectedRow)
            }
            
            Divider()
            Spacer().frame(height: 12)
            SettingsButtonModule(module: $selectedModule, selectedPoint: $selectedCoords.animation(.easeInOut(duration: 0.2)))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color(.secondarySystemBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Abort", role: .cancel) {
                    // Dont apply changes and go back
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Apply") {
                    // Override original data
                    originalModule = selectedModule
                    configuration.save()
                    dismiss()
                }
            }
        }
        .navigationTitle("Edit Module")
        .navigationBarTitleDisplayMode(.inline)
    }
}
