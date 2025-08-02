//
//  HabitDetailViewModel.swift
//  Habitor
//
//  Created by Vadim Kononenko on 02.08.2025.
//

import Foundation

// MARK: - CalendarDay
struct CalendarDay {
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
    let isCompleted: Bool
}

class HabitDetailViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var calendarDays: [CalendarDay] = []
    
    // MARK: - Variables
    private let habit: Habit
    private let calendar = Calendar.current
    
    // MARK: - Init
    init(habit: Habit) {
        self.habit = habit
        updateCalendarDays()
    }
        
    // MARK: - Methods
    func previousMonth() {
        selectedDate = calendar
            .date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
        updateCalendarDays()
    }
        
    func nextMonth() {
        selectedDate = calendar
            .date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
        updateCalendarDays()
    }
        
    func isCompletedToday() -> Bool {
        return isCompletedDay(Date())
    }
        
    var monthYearString: String {
        monthYearFormatter.string(from: selectedDate)
    }
        
    var weekdaySymbols: [String] {
        let formatter = DateFormatter()
        let symbols = formatter.shortWeekdaySymbols ?? [
            "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
        ]
        ///Making Monday first
        return Array(symbols[1...]) + [symbols[0]]
    }
    
    func updateCalendarDays() {
        calendarDays = generateCalendarDays()
    }
        
    func generateCalendarDays() -> [CalendarDay] {
        let startOfMonth = calendar.dateInterval(
            of: .month,
            for: selectedDate
        )?.start ?? selectedDate
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let mondayBasedWeekday = (firstWeekday + 5) % 7
            
        var days = [CalendarDay]()
            
        ///Adding days from prev month
        days.append(contentsOf: generatePreviousMonthDays(
            mondayBasedWeekday: mondayBasedWeekday,
            startOfMonth: startOfMonth
        ))
            
        ///Adding days current month
        days.append(contentsOf: generateCurrentMonthDays(startOfMonth: startOfMonth))
            
        ///Adding days from next month
        days.append(contentsOf: generateNextMonthDays(currentDaysCount: days.count))
            
        return days
    }
        
    func generatePreviousMonthDays(
        mondayBasedWeekday: Int,
        startOfMonth: Date
    ) -> [CalendarDay] {
        guard mondayBasedWeekday > 0 else { return [] }
            
        let previousMonth = calendar.date(
            byAdding: .month,
            value: -1,
            to: selectedDate
        ) ?? selectedDate
        let daysInPreviousMonth = calendar.range(
            of: .day,
            in: .month,
            for: previousMonth
        )?.count ?? 30
            
        var days = [CalendarDay]()
            
        for dayOffset in (mondayBasedWeekday - 1)..<mondayBasedWeekday {
            let dayNumber = daysInPreviousMonth - dayOffset
            if let date = calendar.date(
                byAdding: .day,
                value: dayNumber - daysInPreviousMonth,
                to: startOfMonth
            ) {
                days.append(CalendarDay(
                    day: dayNumber,
                    date: date,
                    isCurrentMonth: false,
                    isCompleted: isCompletedDay(date)
                ))
            }
        }
            
        return days
    }
        
    func generateCurrentMonthDays(startOfMonth: Date) -> [CalendarDay] {
        let daysInMonth = calendar.range(
            of: .day,
            in: .month,
            for: selectedDate
        )?.count ?? 30
        var days = [CalendarDay]()
            
        for day in 1...daysInMonth {
            if let date = calendar.date(
                byAdding: .day,
                value: day - 1,
                to: startOfMonth
            ) {
                days.append(CalendarDay(
                    day: day,
                    date: date,
                    isCurrentMonth: true,
                    isCompleted: isCompletedDay(date)
                ))
            }
        }
            
        return days
    }
        
    func generateNextMonthDays(currentDaysCount: Int) -> [CalendarDay] {
        let totalCells = 42 // 6 weeks * 7 days
        let remainingCells = totalCells - currentDaysCount
            
        guard remainingCells > 0 else { return [] }
            
        let nextMonth = calendar.date(
            byAdding: .month,
            value: 1,
            to: selectedDate
        ) ?? selectedDate
        let startOfNextMonth = calendar.dateInterval(
            of: .month,
            for: nextMonth
        )?.start ?? nextMonth
            
        var days = [CalendarDay]()
            
        for day in 1...remainingCells {
            if let date = calendar.date(
                byAdding: .day,
                value: day - 1,
                to: startOfNextMonth
            ) {
                days.append(CalendarDay(
                    day: day,
                    date: date,
                    isCurrentMonth: false,
                    isCompleted: isCompletedDay(date)
                ))
            }
        }
            
        return days
    }
        
    func isCompletedDay(_ date: Date) -> Bool {
        guard let entries = habit.entries else { return false }
            
        return entries.first { entry in
            calendar.isDate(entry.date, inSameDayAs: date)
        }?.isCompleted ?? false
    }
        
    var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.locale = Locale.current
        return formatter
    }
}
