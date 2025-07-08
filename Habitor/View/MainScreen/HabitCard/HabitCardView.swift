//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {
    
    var habit: Habit
    
    var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
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
            //action
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                
                Image(systemName: "checkmark")
                    .fontWeight(.bold)
            }
        }
        .frame(width: 40, height: 40)
    }
}

// MARK: - Helper Methods
extension HabitCardView {
    func getHabitEntry(for habit: Habit, on date: Date) -> HabitEntry? {
        habit.entries?.first(where: { $0.date == date })
    }
    
    private func getCategotyTagColor(for category: Category) -> Color {
        Color(hex: category.colorHex ?? "FFFFFF") ?? .white
    }
}
