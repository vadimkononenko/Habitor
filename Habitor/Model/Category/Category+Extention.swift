//
//  Category+Extention.swift
//  Habitor
//
//  Created by Vadim Kononenko on 19.07.2025.
//

import Foundation
import SwiftUI

// MARK: - Category Extensions
extension Category {
    var color: Color {
        Color(hex: colorHex ?? "007AFF") ?? .blue
    }
    
    var habitCount: Int {
        habits?.count ?? 0
    }
    
    var isValid: Bool {
        guard let name = name?.trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty else { return false }
        
        return true
    }
}
