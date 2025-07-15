//
//  CalendarGrid.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct CalendarGrid: View {
    let habitData: [Date: Bool]
    let month: Date
        
    private let weekdays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 4),
        count: 7
    )
        
    private var monthDays: [Date?] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
            return []
        }
            
        let firstOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let daysInMonth = calendar.range(
            of: .day,
            in: .month,
            for: month
        )?.count ?? 0
            
        var days: [Date?] = []
            
        // Добавляем пустые дни в начале
        for _ in 1..<firstWeekday {
            days.append(nil)
        }
            
        // Добавляем дни месяца
        for day in 1...daysInMonth {
            if let date = calendar.date(
                byAdding: .day,
                value: day - 1,
                to: firstOfMonth
            ) {
                days.append(date)
            }
        }
            
        return days
    }
        
    var body: some View {
        VStack(spacing: 8) {
            // Заголовки дней недели
            HStack(spacing: 4) {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
                
            // Сетка дней
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(
                    Array(monthDays.enumerated()),
                    id: \.offset
                ) { _, date in
                    if let date = date {
                        DaySquare(
                            date: date,
                            isCompleted: habitData[Calendar.current.startOfDay(
                                for: date
                            )] ?? false
                        )
                    } else {
                        Color.clear
                            .frame(width: 36, height: 36)
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarGrid(
        habitData: [
            Calendar.current.startOfDay(for: Date()): true,
            Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: Date())!): false,
            Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -2, to: Date())!): true
        ],
        month: Date()
    )
    .padding()
}
