//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {
    // MARK: - Environment
    @EnvironmentObject private var viewModel: HabitViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - Properties
    let habit: Habit
    
    // MARK: - Body
    var body: some View {
        VStack {
            HabitCardHeaderView(habit: habit, isCompleted: isCompletedToday) {
                handleCompletionToday()
            }
            
            HabitCardFooterView(habit: habit)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        )
    }
    
    // MARK: - Computed Properties
    var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
    }
    
    var todayHabitEntry: HabitEntry? {
        viewModel.getHabitEntry(for: habit, on: Date())
    }
    
    var isCompletedToday: Bool {
        todayHabitEntry?.isCompleted ?? false
    }
    
    // MARK: - Actions
    private func handleCompletionToday() {
        withAnimation(.spring(response: 0.3)) {
            viewModel.completeHabitEntry(for: habit, on: Date())
        }
    }
}
