//
//  CompletionListView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 08.07.2025.
//

import SwiftUI

struct CompletionListView: View {
    @ObservedObject var habit: Habit
    @StateObject private var viewModel: CompletionListViewModel
    
    init(habit: Habit) {
        self.habit = habit
        self._viewModel = StateObject(
            wrappedValue: CompletionListViewModel(habit: habit)
        )
    }

    var body: some View {
        HStack(spacing: 16) {
            ForEach(Array(viewModel.completionDays.enumerated()), id: \.offset) { index, day in
                CompletionItemView(habit: habit,
                                   date: day.date,
                                   isCompleted: day.isCompleted)
            }
        }
        .onChange(of: habit.entries?.count) { _, _ in
            viewModel.refreshData()
        }
    }
}
