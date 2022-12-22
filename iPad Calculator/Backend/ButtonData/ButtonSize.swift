//
//  ButtonSize.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation
import SwiftUI

class ButtonModuleSize: ObservableObject {
    @Published var buttonSize: CGFloat
    @Published var buttonSpace: CGFloat
    @Published var insetSize: CGFloat
    
    let moduleSize: (width: Int, height: Int)
    
    var moduleWidth: CGFloat {
        CGFloat(moduleSize.width) * buttonSize + CGFloat(moduleSize.width) * buttonSpace
    }
    
    var moduleHeight: CGFloat {
        CGFloat(moduleSize.height) * buttonSize + CGFloat(moduleSize.height) * buttonSpace
    }
    
    init(buttonSize: CGFloat = 64, buttonSpace: CGFloat = 16, insetSize: CGFloat = 12, moduleSize: (width: Int, height: Int) = (4, 5)) {
        self.buttonSize = buttonSize
        self.buttonSpace = buttonSpace
        self.insetSize = insetSize
        self.moduleSize = moduleSize
    }
    
    func totalWidth(_ span: Int) -> CGFloat {
        CGFloat(span) * buttonSize + CGFloat(span - 1) * buttonSpace
    }
}

