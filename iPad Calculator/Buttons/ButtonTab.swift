//
//  ButtonTab.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct ButtonTab<Content: View, TabData>: View {
    
    struct TabItem: Identifiable {
        var data: TabData
        var icon: String
        var enabled: Bool
        var id = UUID()
        
        init(_ data: TabData, icon: String = "star.fill", enabled: Bool = true) {
            self.data = data
            self.icon = icon
            self.enabled = enabled
        }
    }
    
    @Namespace var namespace
    @State var selection: TabItem
    
    init(_ tabs: [TabItem], content: @escaping (TabData) -> Content) {
        self._tabs = State(initialValue: tabs)
        self.content = content
        self._selection = State(initialValue: tabs.first!)
    }
    
    @State var tabs: [TabItem]
    
    var content: (TabData) -> Content
    
    var body: some View {
        VStack(spacing: 16) {
            content(selection.data)
            
            HStack {
                ForEach(tabs) {tab in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {selection = tab}
                    } label: {
                        Label("", systemImage: tab.icon)
                            .labelStyle(.iconOnly)
                            .padding(8)
                    }
                    .background(Color.accentColor.opacity(selection.id == tab.id ? 0.2 : 0))
                    .cornerRadius(8)
                    .disabled(!tab.enabled)
                }
            }
        }
    }
}

struct ButtonTab_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTab([
            .init(4, icon: "house"),
            .init(2, icon: "gear"),
            .init(6, icon: "circle.fill", enabled: false),
        ]) {
            Text(String($0))
        }
    }
}

