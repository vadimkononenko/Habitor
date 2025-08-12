//
//  CompletionItemView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 16.07.2025.
//

import SwiftUI

struct CompletionItemView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    
    var habit: Habit
    var date: Date
    var isCompleted: Bool
    
    var body: some View {
        VStack {
            Text(getFormattedDate(for: date))
                .font(.caption2)
                .fixedSize()
            
            Button {
                handleCompletion()
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(isCompleted ? Color.accentColor : Color.gray.opacity(0.5))
                    .frame(width: 18, height: 18)
            }
        }
    }
}

extension CompletionItemView {
    private func handleCompletion() {
        viewModel.completeHabitEntry(for: habit, on: date)
    }
}

extension CompletionItemView {
    private func getFormattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
}
