//
//  HabitCalendarView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct HabitCalendarView: View {
    @State private var selectedMonth = Date()
        
    // Моковые данные
    private var mockData: [Date: Bool] {
        var data: [Date: Bool] = [:]
        let calendar = Calendar.current
            
        // Генерируем данные за последние 60 дней
        for i in 0...60 {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Рандомное выполнение с вероятностью 70%
                data[normalizeDate(date)] = Bool
                    .random() && Bool
                    .random() || Bool
                    .random()
            }
        }
            
        return data
    }
        
    var body: some View {
        VStack(spacing: 16) {
            // Статистика месяца
            MonthStats(habitData: mockData, month: selectedMonth)
            
            // Навигация по месяцам
            MonthNavigation(selectedMonth: $selectedMonth)
                
            // Календарная сетка
            CalendarGrid(habitData: mockData, month: selectedMonth)
                
            // Легенда
            Legend()
        }
        .padding()
    }
        
    private func normalizeDate(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}

#Preview {
    HabitCalendarView()
}
