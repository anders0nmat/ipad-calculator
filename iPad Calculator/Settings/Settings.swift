//
//  Settings.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct SettingsPage: Identifiable {
    var id = UUID()
    
    var label: () -> AnyView
    var content: () -> AnyView
    
    init<L: View, C: View>(label: @escaping () -> L, content: @escaping () -> C) {
        self.label = { AnyView(label()) }
        self.content = { AnyView(content()) }
    }
    
    init<S: StringProtocol, C: View>(_ label: S, content: @escaping () -> C) {
        self.label = { AnyView(Text(label)) }
        self.content = { AnyView(content()) }
    }
    
}

struct Settings: View {
    static let pages: [SettingsPage] = [
        .init("More", content: {Text("More stuff :)")})
    ]
    
    var body: some View {
        NavigationSplitView {
            List(Settings.pages) { page in
                NavigationLink {
                    page.content()
                        .toolbar {
                            Text("Done")
                        }
                } label: {
                    page.label()
                }
            }
        } detail: {
            Text("Click something")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
