//
//  MonthStats.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct MonthStats: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: true)]
    ) private var habits: FetchedResults<Habit>
    
    let habitData: [Date: Bool]
    let month: Date
    
    private var daysInMonth: Int {
        let calendar = Calendar.current
        
        return calendar.range(
            of: .day,
            in: .month,
            for: month
        )?.count ?? 0
    }
    
    
    
    private var stats: (completed: Int, total: Int, percentage: Int) {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
            return (0, 0, 0)
        }
            
        let daysInMonth = calendar.range(
            of: .day,
            in: .month,
            for: month
        )?.count ?? 0
        var completedDays = 0
            
        for day in 1...daysInMonth {
            if let date = calendar.date(
                byAdding: .day,
                value: day - 1,
                to: monthInterval.start
            ) {
                let normalizedDate = calendar.startOfDay(for: date)
                if habitData[normalizedDate] == true {
                    completedDays += 1
                }
            }
        }
            
        let percentage = daysInMonth > 0 ? Int(
            (Double(completedDays) / Double(daysInMonth)) * 100
        ) : 0
            
        return (completedDays, daysInMonth, percentage)
    }
        
    var body: some View {
        VStack(spacing: 12) {
            Text("Статистика месяца")
                .font(.headline)
                
            HStack(spacing: 20) {
                StatCard(
                    title: "Выполнено",
                    value: "\(stats.completed)",
                    subtitle: "дней"
                )
                StatCard(
                    title: "Всего",
                    value: "\(stats.total)",
                    subtitle: "дней"
                )
                StatCard(
                    title: "Успех",
                    value: "\(stats.percentage)",
                    subtitle: "%"
                )
            }
        }
        .padding()
    }
}

#Preview {
    MonthStats(
        habitData: [
            Calendar.current.startOfDay(for: Date()): true,
            Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: Date())!): false,
            Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -2, to: Date())!): true
        ],
        month: Date()
    )
    .padding()
}
