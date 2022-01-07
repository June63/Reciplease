//
//  StringExtension.swift
//  Reciplease
//
//  Created by Léa Kieffer on 23/12/2021.
//

import Foundation

// MARK: - Formatting String
extension String {
    var isEmptyOrWhitespace: Bool {
          return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      }
}

// Out of range
extension Collection {
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

