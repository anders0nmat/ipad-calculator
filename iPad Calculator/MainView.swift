//
//  MainView.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var engine: CalculatorEngine
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    // TODO: Variable-List View
                    NavigationStack {
                        HistoryList()
                            .toolbar {
                                ToolbarItemGroup(placement: .navigationBarTrailing) {
                                    ToolbarItems()
                                }
                            }
                    }
                    
                }
                Divider()
                ButtonArea(availableSpace: reader.size.width, action: engine.processCommand)
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    @StateObject static var engine = CalculatorEngine()
    @StateObject static var buttonSizes = ButtonModuleSize()
    @StateObject static var configuration = ButtonConfiguration()
    static var previews: some View {
        MainView()
            .environmentObject(engine)
            .environmentObject(buttonSizes)
            .environmentObject(configuration)
    }
}
