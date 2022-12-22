//
//  File.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftMathParser

struct CalculatorEntry: Identifiable {
    var id = UUID()
    
    var parser: Parser { didSet { tree.update()} }
    var tree: TreeNode
    
    init() { self.init(parser: Parser()) }
    init(parser: Parser) {
        self.parser = parser
        self.tree = TreeNode(node: parser.expression)
    }
}
