//
//  HabitCardFooterView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct HabitCardFooterView: View {
    // MARK: - Properties
    let habit: Habit
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom) {
            CompletionListView(habit: habit)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if habit.currentStreak > 0 {
                    StreakView(streak: Int(habit.currentStreak))
                }
                            
                HabitDateView()
            }
        }
    }
}
