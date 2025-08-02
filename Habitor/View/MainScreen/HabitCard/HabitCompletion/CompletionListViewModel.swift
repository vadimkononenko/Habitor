//
//  CompletionListViewModel.swift
//  Habitor
//
//  Created by Vadim Kononenko on 02.08.2025.
//

import Foundation

// MARK: - CompletionDay
struct CompletionDay {
    let date: Date
    let dayNumber: String
    let isCompleted: Bool
    let dayOffset: Int
}

@MainActor
class CompletionListViewModel: ObservableObject {
    @Published var completionDays: [CompletionDay] = []
    
    // MARK: - Variables
    private let habit: Habit
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    // MARK: - Init
    init(habit: Habit) {
        self.habit = habit
        refreshData()
    }
    
    // MARK: - Methods
    func refreshData() {
        updateCompletionDays()
    }
    
    private func updateCompletionDays() {
        completionDays = generateCompletionDays()
    }
    
    private func generateCompletionDays() -> [CompletionDay] {
        var days: [CompletionDay] = []
        
        for dayOffset in -6..<1 {
            let date = getDateDaysAgo(dayOffset)
            let dayNumber = dateFormatter.string(from: date)
            let isCompleted = isCompletedDay(date)
            
            days.append(
                CompletionDay(date: date,
                              dayNumber: dayNumber,
                              isCompleted: isCompleted,
                              dayOffset: dayOffset)
            )
        }
        
        return days
    }
    
    private func getDateDaysAgo(_ days: Int) -> Date {
        let calendar = Calendar.current
        
        if let date = calendar.date(
            byAdding: .day,
            value: days,
            to: Date()
        ) {
            return date
        }
        
        return Date()
    }
    
    private func isCompletedDay(_ date: Date) -> Bool {
        guard let entries = habit.entries else { return false }
        
        return entries.first { entry in
            let entryDate = entry.date
            return Calendar.current.isDate(entryDate, inSameDayAs: date)
        }?.isCompleted ?? false
    }
}
