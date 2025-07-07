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
    
    private func getCategotyTagColor(for category: Category) -> Color {
        Color(hex: category.colorHex ?? "FFFFFF") ?? .white
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                headerView
                
                HStack(spacing: 20) {
                    ForEach(0..<7) { item in
                        VStack {
                            Text("\(item + 1)")
                                .font(.caption2)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 16, height: 16)
                                .background(Color.gray)
                        }
                    }
                }
                .padding(.top, 8)
            }
            
            Spacer()
            
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
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        )
    }
    
    // MARK: - Subviews
    private var headerView: some View {
        Text(habit.title ?? "NOTITLE")
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
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .background(getCategotyTagColor(for: category))
            .cornerRadius(12)
            .font(.caption2)
    }
    
    private var infoView: some View {
        HStack(spacing: 40) {
            HStack {
                Image(systemName: "calendar")
                Text(currentFormattedDate)
            }
            .font(.footnote)
            
            energyView
        }
    }
    
    private var energyView: some View {
        Text("\(habitEntry?.energyEarned ?? 0) ")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(Color.accentColor)
        + Text("/ \(habit.energyReward)")
            .font(.caption)
        + Text("⚡️")
            .font(.caption)
    }
    
    private var energyBar: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.accentColor)
            .frame(height: 5)
            .frame(maxWidth: .infinity)
    }
    
    private var completeButton: some View {
        HStack {
            energyView
                .frame(maxWidth: .infinity)
            
            Button {
                // action
            } label: {
                buttonLabel
            }
            .padding()
        }
    }
    
    private var buttonLabel: some View {
        HStack {
            Image(systemName: "checkmark")
        }
        .foregroundColor(.white)
        .font(.headline)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(isCompleted ? Color.green : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
//        .background(Color.accentColor)
        .cornerRadius(6)
    }
}

// MARK: - Helper Methods
extension HabitCardView {
    func getHabitEntry(for habit: Habit, on date: Date) -> HabitEntry? {
        habit.entries?.first(where: { $0.date == date })
    }
}

//#Preview {
//    let viewModel = HabitViewModel(coreDataManager: CoreDataManager.shared)
//    HabitCardView(habit: viewModel.habits.fir)
//}
