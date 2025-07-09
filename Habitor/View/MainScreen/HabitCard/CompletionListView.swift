//
//  CompletionListView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 08.07.2025.
//

import SwiftUI

struct CompletionListView: View {
    @ObservedObject var habit: Habit
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(-6..<1) { dayOffset in
                createCompletionItem(dayOffset: dayOffset)
            }
        }
    }
}

// MARK: - Views
extension CompletionListView {
    @ViewBuilder
    private func createCompletionItem(dayOffset: Int) -> some View {
        VStack {
            Text(getFormattedDate(for: getDateDaysAgo(dayOffset)))
                .font(.caption2)
                .fixedSize()
            
            RoundedRectangle(cornerRadius: 4)
                .fill(isCompletedDay(getDateDaysAgo(dayOffset)) ? Color.accentColor : Color.gray.opacity(0.5))
                .frame(width: 18, height: 18)
        }
    }
}

// MARK: - Hepler Methods
extension CompletionListView {
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
    
    private func getFormattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
    
    private func isCompletedDay(_ date: Date) -> Bool {
        guard let entries = habit.entries else { return false }
        
        return entries.first { entry in
            guard let entryDate = entry.date else { return false }
            return Calendar.current.isDate(entryDate, inSameDayAs: date)
        }?.isCompleted ?? false
    }
}
