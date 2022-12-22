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
    
    init(_ entry: CalculatorEntry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Outline(entry.tree.children!.first!, children: \.children, content: HistoryLine.init)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
            
            HistoryResult(entry.tree.result)
                .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 20))
        }
        .padding(.horizontal, 20)
    }
}
