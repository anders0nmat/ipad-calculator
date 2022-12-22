//
//  TreeNode.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI
import SwiftMathParser

struct TreeNode: Identifiable {
    var id = UUID()
    
    private static let colors: [Color] = [.red, .orange, .yellow]
    
    static func argColor(_ index: Array.Index) -> Color {
        return colors[index % colors.endIndex]
    }
    
    weak var node: EvaluableTreeNode?
    var children: [TreeNode]?
    
    var argName: String?
    var argColor: Color?
    
    var displayColor: Color { argColor ?? .gray }
    var backgroundColor: Color { displayColor.opacity(0.2) }
    
    var errors: Bool = false
    var result: ExpressionResult = .number(.nan)
    
    init(node: EvaluableTreeNode, argName: String? = nil, argColor: Color? = nil) {
        self.node = node
        self.children = node.children?.enumerated().map {
            TreeNode(
                node: $0.element,
                argName: node.value.argumentName($0.offset),
                argColor: TreeNode.argColor($0.offset)
            )
        }
        self.argName = argName
        self.argColor = argColor
        
        do {
            self.result = try node.evaluate()
        }
        catch {
            self.errors = true
        }
    }
    
    mutating func update() {
        self.children = node?.children?.enumerated().map {
            TreeNode(
                node: $0.element,
                argName: node?.value.argumentName($0.offset),
                argColor: TreeNode.argColor($0.offset)
            )
        }
        
        do {
            self.result = try node!.evaluate()
        }
        catch {
            self.errors = true
        }
    }
    
    
}
