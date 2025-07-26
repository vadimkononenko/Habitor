//
//  StatisticView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 23.06.2025.
//

import SwiftUI

struct StatisticView: View {
    @State private var selectedMonth = Date()
    
    ///пройтись по всем habit
    ///посчитать для каждого habit общее выполнение с учетом выбраной частоты выполнения
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: true)]
    )
    private var habits: FetchedResults<Habit>
    
//    private var completions: [Date: Bool] {
//        
//    }
    
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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                MonthStats(habitData: mockData, month: selectedMonth)
            }
            .padding()
        }
    }
    
    private func normalizeDate(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}

#Preview {
    StatisticView()
}
