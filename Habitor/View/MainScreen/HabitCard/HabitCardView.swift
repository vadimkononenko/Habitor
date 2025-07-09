//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    
    var habit: Habit
    
    var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
    }
    
    var todayHabitEntry: HabitEntry? {
        guard let entries = habit.entries else { return nil }
        
        let today = Date()
        
        return entries.first { entry in
            guard let entryDate = entry.date else { return false }
            return Calendar.current.isDate(entryDate, inSameDayAs: today)
        }
    }
    
    var isCompletedToday: Bool {
        todayHabitEntry?.isCompleted ?? false
    }
    
    var body: some View {
        VStack {
            createHeaderSection()
            
            createBottomSection()
                .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        )
    }
}

// MARK: - Views
extension HabitCardView {
    @ViewBuilder
    private func createHeaderSection() -> some View {
        HStack {
            createTitleSection()
            Spacer()
            createCompletionButton()
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func createBottomSection() -> some View {
        HStack(alignment: .bottom) {
            CompletionListView(habit: habit)
            
            Spacer()
            
            Text(currentFormattedDate)
                .font(.caption)
        }
    }
    
    @ViewBuilder
    private func createTitleSection() -> some View {
        VStack(alignment: .leading) {
            Text(habit.title ?? "NOTITLE")
            
            HStack {
                ForEach(Array(habit.categories ?? []), id: \.id) { category in
                    Text(category.name ?? "")
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(getCategotyTagColor(for: category))
                        .cornerRadius(12)
                        .font(.caption2)
                }
            }
        }
    }
    
    @ViewBuilder
    private func createCompletionButton() -> some View {
        Button {
            handleCompletionToday()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isCompletedToday ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .fill(isCompletedToday ? Color(#colorLiteral(red: 0.9315781799, green: 0.9315781799, blue: 0.9315781799, alpha: 1)) : Color.white)
                
                Image(systemName: "checkmark")
                    .fontWeight(.bold)
                    .foregroundColor(isCompletedToday ? Color.green : Color.accentColor)
            }
        }
        .frame(width: 40, height: 40)
    }
}

// MARK: - Helper Methods
extension HabitCardView {
    func handleCompletionToday() {
        guard let entry = todayHabitEntry else {
            viewModel.createHabitEntry(for: habit)
            return
        }
        
        viewModel.deleteHabitEntry(entry)
    }
    
    func getHabitEntry(for habit: Habit, on date: Date) -> HabitEntry? {
        habit.entries?.first(where: { $0.date == date })
    }
    
    private func getCategotyTagColor(for category: Category) -> Color {
        Color(hex: category.colorHex ?? "FFFFFF") ?? .white
    }
}
