//
//  ProgressChart.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct ProgressChart: View {
    let data: [ChartData]
    let maxValue: Double = 100
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Заголовок
            HStack {
                Text("Статистика по дням")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
                
            // График
            VStack(spacing: 8) {
                // Y-ось (проценты)
                HStack {
                    VStack(alignment: .trailing, spacing: 0) {
                        ForEach([100, 75, 50, 25, 0], id: \.self) { value in
                            HStack {
                                Text("\(value)%")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 30, alignment: .trailing)
                                Spacer()
                            }
                            .frame(height: 30)
                        }
                    }
                        
                    // Область графика
                    VStack(spacing: 0) {
                        // Горизонтальные линии сетки
                        ForEach(0..<5) { _ in
                            Divider()
                                .background(Color.gray.opacity(0.3))
                            Spacer()
                                .frame(height: 29)
                        }
                    }
                    .frame(height: 150)
                    .overlay(
                        // Столбцы графика
                        HStack(alignment: .bottom, spacing: 8) {
                            ForEach(data, id: \.id) { item in
                                VStack(spacing: 4) {
                                    // Столбец
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.blue)
                                        .frame(
                                            width: 24,
                                            height: CGFloat(
                                                item.value / maxValue
                                            ) * 150
                                        )
                                        .animation(
                                            .easeInOut(duration: 0.6),
                                            value: item.value
                                        )
                                }
                            }
                        }
                            .padding(.horizontal, 4),
                        alignment: .bottom
                    )
                }
                    
                // X-ось (дни/периоды)
                HStack {
                    // Отступ для Y-ось
                    Spacer()
                        .frame(width: 34)
                        
                    // Подписи X-оси
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(data, id: \.id) { item in
                            Text(item.label)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 24)
                        }
                    }
                    .padding(.horizontal, 4)
                        
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    var weeklyData: [ChartData] {
        [
            ChartData(label: "Пн", value: 80),
            ChartData(label: "Вт", value: 90),
            ChartData(label: "Ср", value: 60),
            ChartData(label: "Чт", value: 100),
            ChartData(label: "Пт", value: 70),
            ChartData(label: "Сб", value: 85),
            ChartData(label: "Вс", value: 95)
        ]
    }
    
    return ProgressChart(data: weeklyData)
}
