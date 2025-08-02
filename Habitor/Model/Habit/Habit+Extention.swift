//
//  Habit+Extention.swift
//  Habitor
//
//  Created by Vadim Kononenko on 19.07.2025.
//

import Foundation
import CoreData

// MARK: - Habit Extensions
extension Habit {
    
    // MARK: - Computed Properties
    var completionRate: Double {
        guard let createdAt = createdAt else { return 0.0 }
        
        let daysSinceCreation = Calendar.current.dateComponents(
            [.day],
            from: createdAt,
            to: Date()
        ).day ?? 0
        
        guard daysSinceCreation > 0 else { return 0.0 }
        
        let completedDays = totalCompletions
        return Double(completedDays) / Double(daysSinceCreation + 1)
    }
    
    var weeklyCompletions: Int {
        guard let entries = entries else { return 0 }
        
        let calendar = Calendar.current
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        
        return entries.filter { entry in
            let entryDate = entry.date
            
            guard entry.isCompleted else { return false }
            
            return entryDate >= oneWeekAgo
        }.count
    }
    
    var monthlyCompletions: Int {
        guard let entries = entries else { return 0 }
        
        let calendar = Calendar.current
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        
        return entries.filter { entry in
            let entryDate = entry.date
            
            guard entry.isCompleted else { return false }
            
            return entryDate >= oneMonthAgo
        }.count
    }
    
    // MARK: - Helper Methods
    func isCompletedOn(date: Date) -> Bool {
        guard let entries = entries else { return false }
        
        return entries.contains { entry in
            let entryDate = entry.date
            return Calendar.current
                .isDate(entryDate, inSameDayAs: date) && entry.isCompleted
        }
    }
    
    func getEntryFor(date: Date) -> HabitEntry? {
        guard let entries = entries else { return nil }
        
        return entries.first { entry in
            let entryDate = entry.date
            return Calendar.current.isDate(entryDate, inSameDayAs: date)
        }
    }
    
    func shouldShowOn(date: Date) -> Bool {
        let weekday = Calendar.current.component(.weekday, from: date)
        return targetDays.contains(weekday)
    }
    
    func getCompletionHistory(for days: Int) -> [Date: Bool] {
        var history: [Date: Bool] = [:]
        let calendar = Calendar.current
        
        for i in 0..<days {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                let startOfDay = calendar.startOfDay(for: date)
                history[startOfDay] = isCompletedOn(date: startOfDay)
            }
        }
        
        return history
    }
    
    // MARK: - Validation
    var isValid: Bool {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard
            !title.isEmpty, !targetDays.isEmpty
        else { return false }
        
        return true
    }
}
