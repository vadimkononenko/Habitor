//
//  ProfileView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 23.06.2025.
//

import SwiftUI

struct ProfileView: View {
    
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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .overlay(alignment: .bottomTrailing) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            )
                    }
                
                Text("Vadym Kononenko")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HabitCalendarView()
                
                ProgressChart(data: weeklyData)
            }
        }
    }
}

// MARK: - Helper Views

extension ProfileView {
    func specItemView(with title: String, count: Int) -> some View {
        HStack {
            Text("\(title):")
                .font(.headline)
                .fontWeight(.bold)
            
            GeometryReader { geometry in
                HStack(spacing: 2) {
                    ForEach(0..<Int(geometry.size.width / 5), id: \.self) { _ in
                        Text("·")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(height: 5)
            
            Text("\(count)")
        }
    }
}

#Preview {
    ProfileView()
}
