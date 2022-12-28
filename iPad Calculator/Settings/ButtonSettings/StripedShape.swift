//
//  StripedShape.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 28.12.22.
//

import Foundation
import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
    }
    
    init(size: Int) {
        self.init(rows: size, columns: size)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double (rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}
