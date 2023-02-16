//
//  MainView.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var engine: CalculatorEngine
    
    @State var showVariables: Bool = true
    @Environment(\.horizontalSizeClass) var horzSize
    
    private var hasVariables: Bool {
        !engine.variables.isEmpty || !engine.functionOrder.isEmpty
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    if hasVariables && showVariables && horzSize != .compact {
                        VariableList()
                            .frame(width: reader.size.width * 0.3)
                        Divider()
                    }
                    NavigationStack {
                        HistoryList()
                            .toolbar {
                                ToolbarItemGroup(placement: .navigationBarTrailing) {
                                    ToolbarItems(variablesShown: $showVariables.animation(.easeInOut(duration: 0.2)))
                                }
                            }
                            .background(Color(uiColor: .secondarySystemBackground))
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
