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
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 7)
    
    // MARK: - Body
    var body: some View {
        VStack {
            HabitDetailInfoView(title: habit.title,
                                description: habit.descriptionText,
                                isCompletedToday: isCompletedDay())
                .frame(maxWidth: .infinity, alignment: .center)
            
            HabitDetailStatsView(bestStreak: Int(habit.bestStreak),
                                 currentStreak: Int(habit.currentStreak),
                                 totalCompletions: Int(habit.totalCompletions))
                .padding(.vertical)
            
            //Grid Of Month Days Completions
            LazyVGrid(columns: columns) {
                ForEach(Array(calendarDays.enumerated()), id: \.offset) { index, day in
                    CalendarDayView(day: day,
                                    isCompleted: habitMonthCompletions.contains(day))
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Calendar Logic
    private var calendarDays: [Int] {
        let calendar = Calendar.current
        let month = Date()
        
        let startOfMonth = calendar.dateInterval(of: .month, for: month)?.start ?? month
        let daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 30
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        
        var days = [Int]()
        
        ///Convert format from 1=Sunday => to 0=Monday
        ///1=Sunday  |  1 + 5 = 6  |   6 % 7 = 6  |   6 -> last in week
        let mondayBasedWeekday = (firstWeekday + 5) % 7
        
        ///Fills empty days before 1th date
        for _ in 0..<mondayBasedWeekday {
            days.append(0)
        }
        
        ///Fills month days 1,2,3...31
        for day in 1...daysInMonth {
            days.append(day)
        }
        
        return days
    }
    
    private var habitMonthCompletions: [Int] {
        var completions = [Int]()
        
        let habitEntries = habit.entries
                
        let filteredCompletedHabitEntriesByMonth = habitEntries?.filter {
            let calendar = Calendar.current
            let month = Date()
            
            return calendar.isDate($0.date, equalTo: month, toGranularity: .month) && $0.isCompleted
        }
        
        completions = filteredCompletedHabitEntriesByMonth?.compactMap { entry in
            let calendar = Calendar.current
            return calendar.component(.day, from: entry.date)
        } ?? []
        
        return completions
    }
    
    private func isCompletedDay(_ date: Date = Date()) -> Bool {
        guard let entries = habit.entries else { return false }
        
        return entries.first { entry in
            let entryDate = entry.date
            return Calendar.current.isDate(entryDate, inSameDayAs: date)
        }?.isCompleted ?? false
    }
}

// MARK: - HabitDetailInfoView
struct HabitDetailInfoView: View {
    
    let title: String
    let description: String?
    let isCompletedToday: Bool
    
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
    
    let bestStreak: Int
    let currentStreak: Int
    let totalCompletions: Int
    
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
