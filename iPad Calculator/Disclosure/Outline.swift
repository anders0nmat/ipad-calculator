//
//  Outline.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct Outline<Data: Identifiable, Content: View>: View {
    var tree: Data
    var children: KeyPath<Data, [Data]?>
    
    var content: (_ element: Data, _ isOpen: Binding<Bool?>) -> Content
    
    init(_ tree: Data, children: KeyPath<Data, [Data]?>, content: @escaping (_ element: Data, _ isOpen: Binding<Bool?>) -> Content) {
        self.tree = tree
        self.children = children
        self.content = content
    }
    
    var body: some View {
        if let children = tree[keyPath: children], !children.isEmpty {
            Disclosure {
                ForEach(Array(children.enumerated()), id: \.element.id) {
                    if $0 != 0 {
                        Divider()
                    }
                    Outline($1, children: self.children, content: content)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            } label: {
                content(tree, Binding($0))
            }
        }
        else {
            content(tree, .constant(nil))
        }
    }
}

struct Outline_Previews: PreviewProvider {
    struct TreeData: Identifiable {
        var id = UUID()
        var name: String
        var children: [TreeData]? = nil
    }
    
    static let tree = TreeData(name: "Parent", children: [
    TreeData(name: "Child1"),
    TreeData(name: "Child2", children: [
    TreeData(name: "Descendant1")])])
    
    static var previews: some View {
        Outline(tree, children: \.children) { elem, isOpen in
            HStack {
                Text(elem.name)
                if let open = isOpen.wrappedValue {
                    Button {
                        withAnimation {
                            isOpen.wrappedValue!.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .rotationEffect(open ? .degrees(90) : .degrees(0))
                    }
                }
            }
        }
    }
}
