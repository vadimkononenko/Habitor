//
//  HabitCardViewModel.swift
//  Habitor
//
//  Created by Vadim Kononenko on 02.08.2025.
//

import Foundation

@MainActor
class HabitCardViewModel: ObservableObject {
    @Published var isCompletedToday: Bool = false
    @Published var todayHabitEntry: HabitEntry?
    
    // MARK: - Variables
    private let habit: Habit
    private let habitViewModel: HabitViewModel
    private let calendar = Calendar.current
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter
    }
    
    // MARK: - Init
    init(habit: Habit, habitViewModel: HabitViewModel) {
        self.habit = habit
        self.habitViewModel = habitViewModel
        
        updateTodayStatus()
    }
    
    // MARK: - Methods
    func handleCompletionToday() {
        habitViewModel.completeHabitEntry(for: habit, on: Date())
        updateTodayStatus()
    }
    
    func refreshData() {
        updateTodayStatus()
    }
    
    var currentFormattedDate: String {
        dateFormatter.string(from: Date())
    }
    
    private func updateTodayStatus() {
        todayHabitEntry = habitViewModel.getHabitEntry(for: habit, on: Date())
        isCompletedToday = todayHabitEntry?.isCompleted ?? false
    }
}
