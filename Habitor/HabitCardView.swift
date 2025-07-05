//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {
    
    var habit: Habit
    
    // MARK: - Computed Properties
    var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
    }
    
    private var habitEntry: HabitEntry? {
        getHabitEntry(for: habit, on: Date())
    }
    
    private var isCompleted: Bool {
        habitEntry?.isCompleted ?? false
    }
    
    // MARK: - Colors
    private let categoryBackgroundColor = Color(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479)
    private let accentColor = Color(red: 1, green: 0.7066476341, blue: 0.3261104689)
    private let borderColor = Color(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            headerView
            categoriesView
            infoView
            completeButton
        }
        .padding()
        .background(cardBackground)
    }
    
    // MARK: - Subviews
    private var headerView: some View {
        HStack {
            Text(habit.title ?? "NOTITLE")
            
            Spacer()
            
            Image(systemName: "ellipsis")
        }
    }
    
    private var categoriesView: some View {
        HStack {
            ForEach(Array(habit.categories ?? []), id: \.id) { category in
                categoryTag(for: category)
            }
        }
    }
    
    private func categoryTag(for category: Category) -> some View {
        Text(category.name ?? "")
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .background(categoryBackgroundColor)
            .cornerRadius(12)
            .font(.caption2)
    }
    
    private var infoView: some View {
        HStack(spacing: 40) {
            dateView
            energyView
        }
    }
    
    private var dateView: some View {
        HStack {
            Image(systemName: "calendar")
            Text(currentFormattedDate)
        }
        .font(.footnote)
    }
    
    private var energyView: some View {
        HStack(spacing: 18) {
            energyBar
            energyText
        }
        .frame(maxWidth: .infinity)
    }
    
    private var energyBar: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(accentColor)
            .frame(height: 5)
            .frame(maxWidth: .infinity)
    }
    
    private var energyText: some View {
        Text("\(habitEntry?.energyEarned ?? 0)⚡️")
    }
    
    private var completeButton: some View {
        Button {
            // action
        } label: {
            buttonLabel
        }
        .frame(maxWidth: .infinity)
    }
    
    private var buttonLabel: some View {
        HStack {
            if isCompleted {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
            
            Text(isCompleted ? "Completed" : "Complete")
        }
        .foregroundColor(.white)
        .font(.headline)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(accentColor)
        .cornerRadius(6)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(borderColor)
    }
    
    // MARK: - Helper Methods
    func getHabitEntry(for habit: Habit, on date: Date) -> HabitEntry? {
        habit.entries?.first(where: { $0.date == date })
    }
}

//#Preview {
//    let viewModel = HabitViewModel(coreDataManager: CoreDataManager.shared)
//    HabitCardView(habit: viewModel.habits.fir)
//}
