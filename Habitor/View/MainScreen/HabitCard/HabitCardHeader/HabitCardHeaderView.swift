//
//  HabitCardHeaderView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct HabitCardHeaderView: View {
    let habit: Habit
    let isCompleted: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            HabitInfoView(habit: habit)
            Spacer()
            CompletionButton(isCompleted: isCompleted, action: onToggle)
        }
    }
}
