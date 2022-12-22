//
//  HistoryResult.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI
import SwiftMathParser

struct HistoryResult: View {
    var result: ExpressionResult
    
    init(_ result: ExpressionResult) {
        self.result = result
    }
    
    var body: some View {
        HStack {
            Image(systemName: "equal")
            Spacer()
            
            switch result {
            case .number(let value):
                Text(String(value))
            case .function(let args):
                Text("function(\(args.joined(separator: ", ")))")
            }
        }
    }
}

struct HistoryResult_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HistoryResult(.number(41.52))
            HistoryResult(.function(["rad", "x", "y"]) )
        }
    }
}
