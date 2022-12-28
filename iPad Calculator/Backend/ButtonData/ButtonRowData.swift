//
//  ButtonRowData.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import Foundation

struct ButtonRowData: Identifiable, Hashable, Codable {
    var buttons: [ButtonData]
    var inset: Bool = false
    var id = UUID()
    
    func fittingButtonIndices(in space: UInt) -> [Array.Index] {
        var availableSpace = space
        
        var result = [Array<Never>.Index]()
        
        for index in buttons.indices {
            if buttons[index].span > availableSpace {
                break
            }
            
            result.append(index)
            availableSpace -= buttons[index].span
        }
        return result
    }
    
    mutating func fitButtons(in space: UInt) {
        // Adjust button span to fit available space as good as possible
        /*
         Possible configurations:
         1111
         1112
         1122
         1123
         1222
         1223
         1233
         1234
         */
        
        var availableSpace: UInt = space
        var index: Array.Index = 0
        while availableSpace > 0 && index < buttons.endIndex {
            if buttons[index].span <= availableSpace {
                // Button fits in original configuration in the given space
                availableSpace -= buttons[index].span
                index += 1
            }
            else {
                // Button does not fit, adjust size
                buttons[index].span = availableSpace
                // Button will be processed next round
            }
        }
    }
    
    mutating func shuffleId() {
        self.id = UUID()
        for idx in buttons.indices {
            buttons[idx].shuffleId()
        }
    }
}

extension ButtonRowData {
    static func row(_ buttons: ButtonData...) -> ButtonRowData {
        ButtonRowData(buttons: buttons)
    }
    
    static func inset(_ buttons: ButtonData...) -> ButtonRowData {
        ButtonRowData(buttons: buttons, inset: true)
    }
}
