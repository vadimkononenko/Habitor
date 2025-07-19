//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    let habit: Habit
    
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

// MARK: - Computed Variables
extension HabitCardView {
    var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
    }
    
    var todayHabitEntry: HabitEntry? {
        viewModel.getHabitEntry(for: habit, on: Date())
    }
    
    var isCompletedToday: Bool {
        todayHabitEntry?.isCompleted ?? false
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
            
            VStack(alignment: .trailing) {
                if habit.currentStreak > 0 {
                    Text("🔥 \(habit.currentStreak)")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                            
                Text(currentFormattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    @ViewBuilder
    private func createTitleSection() -> some View {
        VStack(alignment: .leading) {
            Text(habit.title ?? "Untitled")
                .font(.headline)
                .lineLimit(2)
            
            if let description = habit.descriptionText,
               !description.isEmpty {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            if let categories = habit.categories,
               !categories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(categories), id: \.id) { category in
                            CategoryTagView(category: category)
                        }
                    }
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
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isCompletedToday ? Color.green : Color.gray.opacity(0.5)
                    )
                    .fill(
                        isCompletedToday ? Color.green
                            .opacity(0.1) : Color.white
                    )
                        
                Image(
                    systemName: isCompletedToday ? "checkmark.circle.fill" : "circle"
                )
                .fontWeight(.medium)
                .foregroundColor(isCompletedToday ? Color.green : Color.gray)
                .scaleEffect(isCompletedToday ? 1.1 : 1.0)
                .animation(.spring(response: 0.3), value: isCompletedToday)
            }
        }
        .frame(width: 44, height: 44)
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Helper Methods
extension HabitCardView {
    private func handleCompletionToday() {
        withAnimation(.spring(response: 0.3)) {
            viewModel.completeHabitEntry(for: habit, on: Date())
        }
    }
}

// MARK: - CategoryTagView
struct CategoryTagView: View {
    let category: Category
    
    var body: some View {
        Text(category.name ?? "")
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(categoryColor.opacity(0.2))
            .foregroundColor(categoryColor)
            .cornerRadius(8)
            .font(.caption2)
    }
    
    private var categoryColor: Color {
        Color(hex: category.colorHex ?? "007AFF") ?? .blue
    }
}
