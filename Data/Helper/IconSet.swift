//
//  IconSet.swift
//  iPad Calculator
//
//  Created by Rosalie Schnappauf on 31.12.22.
//

import Foundation

protocol IconSet {
    var defaultIcon: Self { get }
    var displayName: String { get }
    var rawIcon: String { get }
}

extension IconSet where Self: RawRepresentable, Self.RawValue == String {
    var displayName: String { self.rawValue.capitalized }
    var rawIcon: String { self.rawValue }
}
