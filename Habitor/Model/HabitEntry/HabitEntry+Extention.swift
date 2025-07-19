//
//  HabitEntry+Extention.swift
//  Habitor
//
//  Created by Vadim Kononenko on 19.07.2025.
//

import Foundation

// MARK: - HabitEntry Extensions
extension HabitEntry {
    var formattedDate: String {
        guard let date = date else { return "Unknown" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
    
    var daysSinceCompletion: Int {
        guard let completedAt = completedAt else { return 0 }
        
        return Calendar.current.dateComponents(
            [.day],
            from: completedAt,
            to: Date()
        ).day ?? 0
    }
}
