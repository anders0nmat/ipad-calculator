//
//  Toolbar.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI

struct ToolbarItems: View {
    @State var settingsShown = false
    @Binding var variablesShown: Bool
    var body: some View {
        Toggle(isOn: $variablesShown) {
            Label("", systemImage: "number")
                .labelStyle(.iconOnly)
        }
        
        
        Button {
            settingsShown.toggle()
        } label: {
            Image(systemName: "gear")
        }
        .fullScreenCover(isPresented: $settingsShown) {
            Settings(isOpen: $settingsShown)
        }
    }
}

struct ToolbarItems_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 8) {
            ToolbarItems(variablesShown: .constant(true))
        }
    }
}
