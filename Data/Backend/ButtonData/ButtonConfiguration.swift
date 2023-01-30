//
//  ButtonConfiguration.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 27.12.22.
//

import Foundation

class ButtonConfiguration: ObservableObject, Codable {
    @Published var modules: [ButtonModuleData] = [.numberBlock, .basicFunctions]
    
    @ObjectAppStorage("button_configuration") var storage: [ButtonModuleData] = [.numberBlock, .basicFunctions]
    
    private init(_ modules: [ButtonModuleData]) {
        self.modules = modules
    }
    
    init() {
        self.modules = storage
    }
    
    
    required init(from decoder: Decoder) throws {
        self.modules = try [ButtonModuleData].init(from: decoder)
    }
    
    func encode(to encoder: Encoder) throws {
        try modules.encode(to: encoder)
    }
    
    func save() {
        storage = self.modules
    }
}
