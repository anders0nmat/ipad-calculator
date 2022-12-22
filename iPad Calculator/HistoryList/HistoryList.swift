//
//  HistoryList.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct HistoryList: View {
    @EnvironmentObject var engine: CalculatorEngine
    
    private var historyLength: Int { engine.history.count }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                Spacer().frame(height: 16)
                ForEach(engine.history, content: HistoryEntry.init)
                .onChange(of: historyLength) { [historyLength] newValue in
                    withAnimation {
                        if let lastId = engine.history.last?.id, newValue > historyLength {
                            withAnimation { reader.scrollTo(lastId) }
                        }
                    }
                }
            }
        }
    }
}
