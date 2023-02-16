//
//  HistoryEntry.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI
import SwiftMathParser

struct HistoryEntry: View {
    var entry: CalculatorEntry
    var index: Array.Index
    
    init(_ entry: CalculatorEntry, index: Array.Index) {
        self.entry = entry
        self.index = index
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Outline(entry.tree.children!.first!, children: \.children, content: HistoryLine.init)
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(12)
                .contextMenu {
                    Text("Information")
                    Text("kjansd")
                }
            
            HistoryResult(entry.tree.result, index: index, root: entry.parser.expression)
                .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 20))
        }
        .padding(.horizontal, 20)
    }
}
