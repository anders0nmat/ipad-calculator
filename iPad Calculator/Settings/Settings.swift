//
//  Settings.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct SettingsPage: Identifiable {
    var id = UUID()
    
    var label: String
    var content: () -> AnyView
    
    init<S: StringProtocol, C: View>(_ label: S, content: @escaping () -> C) {
        self.label = String(label)
        self.content = { AnyView(content()) }
    }
    
}

struct Settings: View {
    static let pages: [SettingsPage] = [
        .init("Button Modules", content: {ModuleList()}),
    ]
    
    @Binding var isOpen: Bool
    
    @EnvironmentObject var configuration: ButtonConfiguration
    
    @State var currPage: Array.Index? = 0
    
    func Page(_ number: Array.Index) -> some View {
        NavigationLink(Settings.pages[number].label, value: number)
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $currPage) {
                Section("Buttons") {
                    Page(0)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem {
                    Button {
                        isOpen = false
                    } label: {
                        Text("Done")
                    }
                }
            }
        } detail: {
            if let currPage {
                Settings.pages[currPage].content()
                    .navigationTitle(Settings.pages[currPage].label)
                    .navigationBarTitleDisplayMode(.inline)
            }
            else {
                Text("Select a page")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct Settings_Previews: PreviewProvider {
    
    @StateObject static var configuration: ButtonConfiguration = ButtonConfiguration()
    @StateObject static var size = ButtonModuleSize()
    
    @State static var open: Bool = true
    static var previews: some View {
        Settings(isOpen: $open)
            .environmentObject(configuration)
            .environmentObject(size)
    }
}
