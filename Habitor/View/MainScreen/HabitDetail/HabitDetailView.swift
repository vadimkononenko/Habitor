//
//  HabitDetailView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct HabitDetailView: View {
    
    // MARK: - Variables
    @ObservedObject var habit: Habit
    @StateObject private var viewModel: HabitDetailViewModel
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 7)
    
    init(habit: Habit) {
        self.habit = habit
        self._viewModel = StateObject(wrappedValue: HabitDetailViewModel(habit: habit))
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HabitDetailInfoView(title: habit.title,
                                description: habit.descriptionText,
                                isCompletedToday: viewModel.isCompletedDay(viewModel.selectedDate))
                .frame(maxWidth: .infinity, alignment: .center)
            
            HabitDetailStatsView(bestStreak: Int(habit.bestStreak),
                                 currentStreak: Int(habit.currentStreak),
                                 totalCompletions: Int(habit.totalCompletions))
                .padding(.vertical)
            
            HStack {
                Button {
                    viewModel.previousMonth()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

                Spacer()
                
                Text(viewModel.monthYearFormatter.string(from: viewModel.selectedDate))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    viewModel.nextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                ForEach(viewModel.weekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            //Grid Of Month Days Completions
            LazyVGrid(columns: columns) {
                ForEach(Array(viewModel.calendarDays.enumerated()), id: \.offset) { index, calendarDay in
                    CalendarDayView(
                        day: calendarDay.day,
                        isCompleted: viewModel.isCompletedDay(calendarDay.date),
                        isCurrentMonth: calendarDay.isCurrentMonth
                    )
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - HabitDetailInfoView
struct HabitDetailInfoView: View {
    
    // MARK: - Variables
    let title: String
    let description: String?
    let isCompletedToday: Bool
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .center) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(description ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Image(systemName: "checkmark.circle")
                .opacity(isCompletedToday ? 1.0 : 0.0)
                .foregroundColor(.green)
        }
    }
}

// MARK: - HabitDetailStatsView
struct HabitDetailStatsView: View {
    
    // MARK: - Variables
    let bestStreak: Int
    let currentStreak: Int
    let totalCompletions: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            StatCard(title: "Best streak",
                     value: "\(bestStreak)",
                     subtitle: "Days")
            StatCard(title: "Current streak",
                     value: "\(currentStreak)",
                     subtitle: "Days")
            StatCard(title: "Completions",
                     value: "\(totalCompletions)",
                     subtitle: "Times")
        }
    }
}

// MARK: - CalendarDayView
struct CalendarDayView: View {
    
    // MARK: - Variables
    let day: Int
    let isCompleted: Bool
    let isCurrentMonth: Bool
    
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(isCurrentMonth ? .accent : .gray.opacity(0.3))
            .frame(width: 30, height: 30)
            .opacity(isCompleted ? 1.0 : (isCurrentMonth ? 0.3 : 0.2))
            .overlay {
                Text("\(day)")
                    .font(.caption)
                    .fontWeight(isCurrentMonth ? .bold : .medium)
                    .foregroundColor(isCurrentMonth ? .white : .gray)
            }
    }
}
