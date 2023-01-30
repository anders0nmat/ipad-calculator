//
//  ColorSet.swift
//  iPad Calculator
//
//  Created by Rosalie Schnappauf on 31.12.22.
//

import Foundation
import SwiftUI

protocol ColorSet {
    var defaultColor: Self { get }
    var displayName: String { get }
    var rawColor: Color { get }
}

extension ColorSet where Self: RawRepresentable, Self.RawValue == String {
    var displayName: String { self.rawValue.capitalized }
    var rawColor: Color { Color(self.rawValue) }
}
