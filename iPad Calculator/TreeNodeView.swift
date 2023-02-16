//
//  TreeNodeView.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI
import SwiftMathParser

fileprivate struct HighlightArgumentView<Content: View>: View {
    var content: Content
    var trigger: AnyObject
    var highlight: Color
    
    @EnvironmentObject var engine: CalculatorEngine
    
    var isSelected: Bool { engine.insertPoint === trigger }
    
    init(when node: AnyObject, with color: Color, content: () -> Content) {
        self.content = content()
        self.trigger = node
        self.highlight = color
    }
    
    var body: some View {
        content
            .padding(.vertical, 2)
            .padding(.horizontal, isSelected ? 8 : 0)
            .background(isSelected ? highlight : .clear)
            .cornerRadius(4)
    }
}

let argumentColors: [Color] = [
    .cyan,
    .purple,
    .green,
    .blue,
    .yellow,
    .indigo,
    .mint,
    .brown,
]

let operationViewMap: [String : (TreeNode) -> AnyView] = [
    "#number": { node in
        AnyView(Text(String((node.node!.value as! NumberLiteral).value)))
    },
    "/": { node in
        AnyView(FractionTerm {node.children![0].display()} divisor: {node.children![1].display()})
    },
    "^": { node in
        AnyView(ExponentTerm {node.children![0].display()} exponent: {node.children![1].display()})
    },
    "sqr": { node in
        AnyView(ExponentTerm {node.children![0].display()} exponent: {Text("2")})
    },
    "cbe": { node in
        AnyView(ExponentTerm {node.children![0].display()} exponent: {Text("3")})
    },
    "()": { node in
        AnyView(HStack(spacing: 0) {
            Text("(")
            node.children![0].display()
            Text(")")
        })
    }
]

extension TreeNode {
    private func highlighted<Content: View>(content: () -> Content) -> AnyView {
        AnyView(HighlightArgumentView(when: node!, with: backgroundColor, content: content))
    }
    
    @ViewBuilder
    private func joinChildren(separator: String) -> some View {
        if children != nil {
            ForEach(Array(children!.enumerated()), id: \.element.id) { (index, child) in
                if index != 0 { Text(separator) }
                child.display()
            }
        }
        else {
            EmptyView()
        }
    }
    
    func display() -> AnyView {
        guard let node = node else { return AnyView(Text("Missing")) }
        
        if node.value is EmptyLiteral {
            return highlighted {
                Text(argName ?? "   ")
                    .foregroundColor(displayColor)
            }
        }
        
        if let variableName = (node.value as? VariableLiteral)?.variableName {
            return highlighted { Text(variableName) }
        }
        
        if let handler = operationViewMap[node.value.internalName] {
            return highlighted { handler(self) }
        }
        
        switch node.value.nodeType {
        case .arguments(_), .prefixArgument(_):
            return highlighted {
                HStack(spacing: 4) {
                    Text(node.value.internalName + "(")
                    joinChildren(separator: ", ")
                    Text(")")
                }
            }
        case .priority(_):
            return highlighted {
                HStack(spacing: 4) { joinChildren(separator: node.value.internalName) }
            }
        }
    }
}

