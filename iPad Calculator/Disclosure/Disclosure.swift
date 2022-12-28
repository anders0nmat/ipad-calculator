//
//  Disclosure.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

fileprivate struct _Disclosure<Content: View, Label: View>: View {
    @Binding var isOpen: Bool
    
    var content: () -> Content
    var label: (_ isOpen: Binding<Bool>) -> Label
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            label($isOpen)
                .foregroundColor(.primary)
            VStack(alignment: .center, spacing: 0) {
                content()
                    .frame(height: isOpen ? nil : 0, alignment: .bottom)
                    .opacity(isOpen ? 1 : 0)
            }
            .clipped()
        }
    }
}

struct Disclosure<Content: View, Label: View>: View {
    var isOpen: Binding<Bool>?
    @State private var privateOpen: Bool = false
    var content: () -> Content
    var label: (_ isOpen: Binding<Bool>) -> Label
    
    var body: some View {
        _Disclosure(isOpen: isOpen ?? $privateOpen, content: content, label: label)
    }
}

struct Disclosure_Previews: PreviewProvider {
    static var previews: some View {
        Disclosure {
            Text("hallo")
        } label: { isOpen in
            HStack {
                Text("Open me")
                Button { withAnimation{ isOpen.wrappedValue.toggle() } } label: {
                    Image(systemName: "chevron.right")
                }
            }
        }
    }
}
