//
//  HistoryLine.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct HistoryLine: View {
    var element: TreeNode
    @Binding var isOpen: Bool?
    
    init(_ element: TreeNode, _ isOpen: Binding<Bool?>) {
        self.element = element
        self._isOpen = isOpen
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if element.errors {
                    Image(systemName: "exclamationmark.octagon.fill")
                        .foregroundColor(.red)
                }
                if let name = element.argName {
                    Text(name)
                        .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                        .background(element.backgroundColor)
                        .cornerRadius(4)
                        .foregroundColor(element.displayColor)
                        .lineLimit(1)
                }
                Spacer()
                element.display()
                    .lineLimit(1)
                    .layoutPriority(1)
                Button {
                    withAnimation { isOpen?.toggle() }
                } label: {
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isOpen == true ? 90 : 0))
                        .opacity(isOpen == nil ? 0 : 1)
                        .padding(8)
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            if isOpen == true {
                Divider()
            }
        }
    }
}
