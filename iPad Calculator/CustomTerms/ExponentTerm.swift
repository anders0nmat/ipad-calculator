//
//  ExponentTerm.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct ExponentTerm<Base: View, Exponent: View>: View {
    var base: Base
    var exponent: Exponent
    
    init(@ViewBuilder base: () -> Base, @ViewBuilder exponent: () -> Exponent) {
        self.base = base()
        self.exponent = exponent()
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            base
            VStack(spacing: 0) {
                exponent
                    .scaleEffect(0.8, anchor: .leading)
                Spacer().frame(height: 6)
            }
        }
    }
}

struct ExponentTerm_Previews: PreviewProvider {
    static var previews: some View {
        ExponentTerm {
            Text("35")
        } exponent: {
            Text("2")
        }
    }
}
