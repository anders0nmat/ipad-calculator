//
//  HistoryResult.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI
import SwiftMathParser

struct HistoryResult: View {
    var result: ExpressionResult
    var rootNode: EvaluableTreeNode
    var index: Array.Index
    
    @EnvironmentObject var engine: CalculatorEngine
    @State var variableName: Bool = false
    @State var functionName: Bool = false
    @State var variableStr: String = ""
    
    init(_ result: ExpressionResult, index: Array.Index, root: EvaluableTreeNode) {
        self.result = result
        self.index = index
        self.rootNode = root
    }
    
    var body: some View {
        HStack {
            if case .number(_) = result {
                Text("r\(index)")
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(.blue.opacity(0.2))
                    .cornerRadius(4)
                    .foregroundColor(.blue)
            }

            Image(systemName: "equal")
            
            Spacer()
            
            switch result {
            case .number(let value):
                Text(String(value))
                    .contextMenu {
                        Button("Save as x") {
                            engine.addOrSetVariable(name: "x", value: value)
                        }
                        Button("Save as y") {
                            engine.addOrSetVariable(name: "y", value: value)
                        }
                        Divider()
                        Button("Save as...") {
                            variableName.toggle()
                            
                        }
                        
                    }
                    .alert("Add as Variable", isPresented: $variableName) {
                        TextField("Name", text: $variableStr)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        Button("Ok") {
                            if !variableStr.isEmpty {
                                engine.addOrSetVariable(name: variableStr, value: value)
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter variable name")
                    }
            case .function(let args):
                Text("function(\(args.joined(separator: ", ")))")
                    .contextMenu {
                        Button("Save as f(\(args.joined(separator: ", ")))") {
                            engine.addOrSetFunction(name: "f", expression: rootNode)
                        }
                        Button("Save as g(\(args.joined(separator: ", ")))") {
                            engine.addOrSetFunction(name: "g", expression: rootNode)
                        }
                        Divider()
                        Button("Save as...") {
                            functionName.toggle()
                        }
                    }
                    .alert("Add as Function", isPresented: $functionName) {
                        TextField("Name", text: $variableStr)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                        Button("Ok") {
                            if !variableStr.isEmpty {
                                engine.addOrSetFunction(name: variableStr, expression: rootNode)
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter function name")
                    }
            }
        }
    }
}
