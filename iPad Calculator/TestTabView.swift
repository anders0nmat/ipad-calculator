//
//  TestTabView.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 22.12.22.
//

import SwiftUI

struct TestTabView: View {
    var body: some View {
        VStack {
            ControlGroup {
                Image(systemName: "globe")
                Image(systemName: "house")
            }
            .controlGroupStyle(.navigation)
        }
    }
}

struct TestTabView_Previews: PreviewProvider {
    static var previews: some View {
        TestTabView()
    }
}
