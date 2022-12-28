//
//  iPad_CalculatorApp.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI
import SwiftMathParser

@main
struct iPad_CalculatorApp: App {
    @StateObject var engine = CalculatorEngine()
    @StateObject var buttonSizes = ButtonModuleSize()
    
    @StateObject var buttonConfiguration = ButtonConfiguration()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(engine)
                .environmentObject(buttonSizes)
                .environmentObject(buttonConfiguration)
        }
    }
}
