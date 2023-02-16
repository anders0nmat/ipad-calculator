//
//  VariableList.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 16.02.23.
//

import SwiftUI
import SwiftMathParser

struct VariableList: View {
    private enum ItemType {
        case variable
        case function
    }
    
    @EnvironmentObject var engine: CalculatorEngine
    var body: some View {
        List {
            if !engine.variables.isEmpty {
                Section("Variables") {
                    ForEach(engine.variableOrder, id:\.self) { element in
                        Button {
                            engine.processCommand("#var:" + element)
                        } label: {
                            HStack {
                                Label(element + " :", systemImage: "")
                                    .labelStyle(.titleOnly)
                                    .padding(4)
                                
                                Spacer()
                                
                                Text(String(engine.variables[element] ?? .nan))
                                    .foregroundColor(.primary)
                                
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                engine.removeVariable(name: element)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .labelStyle(.iconOnly)
                            }
                            .tint(.red)
                        }
                        
                    }
                }
            }
            if !engine.functionOrder.isEmpty {
                Section("Functions") {
                    ForEach(engine.functionOrder, id:\.self) { element in
                        Button {
                            engine.processCommand(element)
                        } label: {
                            HStack {
                                Label(element, systemImage: "")
                                    .labelStyle(.titleOnly)
                                    .padding(4)
                                Spacer()
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                engine.removeFunction(name: element)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .labelStyle(.iconOnly)
                                    
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            
        }
        .listStyle(.insetGrouped)
        
    }
}

struct VariableList_Previews: PreviewProvider {
    @StateObject static var engine = CalculatorEngine()
    static var previews: some View {
        VStack {
            VariableList()
                .environmentObject(engine)
            
            Button("Add Variable X") {
                engine.addOrSetVariable(name: "x", value: 3.14)
                engine.addOrSetVariable(name: "y", value: 3.14)
                engine.addOrSetVariable(name: "z", value: 3.14)
            }
        }
    }
}
