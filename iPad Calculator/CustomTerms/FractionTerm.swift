//
//  FractionTerm.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct FractionTerm<Divident: View, Divisor: View>: View {
    var divident: Divident
    var divisor: Divisor
    
    init(@ViewBuilder divident: () -> Divident, @ViewBuilder divisor: () -> Divisor) {
        self.divident = divident()
        self.divisor = divisor()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 0) {
                divident
                Spacer().frame(height: 8)
                divisor
            }
            .padding(.horizontal, 4)
        }
        .overlay {
            VStack(spacing: 0) {
                divident.opacity(0)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 8)
                    .background {
                        Rectangle()
                            .frame(height: 1)
                    }
                Spacer()
            }
        }
    }
}

struct FractionTerm_Previews: PreviewProvider {
    static var previews: some View {
        FractionTerm {
            Text("24.5")
        } divisor: {
            Text("54")
        }
    }
}
