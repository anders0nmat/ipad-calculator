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
    
    @EnvironmentObject var configuration: ButtonConfiguration
    
    @Namespace var namespace
    @State var selectionIndex: Array.Index = 0
    var starting: Array.Index = 0
    
    init(starting: Array.Index = 0, content: @escaping (Binding<ButtonModuleData>) -> Content) where TabData == Never {
        self.content = content
        self.starting = starting
        self._selectionIndex = State(wrappedValue: starting)
    }
    
    var content: (Binding<ButtonModuleData>) -> Content
    
    var body: some View {
        VStack(spacing: 16) {
            content($configuration.modules[selectionIndex])
            
            HStack {
                ForEach(Array(configuration.modules[starting...].enumerated()), id: \.element.id) {index, tab in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {selectionIndex = index + starting}
                    } label: {
                        Label("", systemImage: configuration.modules[index + starting].icon.rawIcon)
                            .labelStyle(.iconOnly)
                            .padding(8)
                    }
                    .background(Color.accentColor.opacity(selectionIndex == index + starting ? 0.2 : 0))
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct ButtonTab_Previews: PreviewProvider {
    static var previews: some View {
        /*ButtonTab([
            .init(4, icon: "house"),
            .init(2, icon: "gear"),
            .init(6, icon: "circle.fill", enabled: false),
        ]) {
            Text(String($0))
        }*/
        EmptyView()
    }
}

