//
//  DaySquare.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct DaySquare: View {
    let date: Date
    let isCompleted: Bool
        
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
        
    private var dayNumber: Int {
        Calendar.current.component(.day, from: date)
    }
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(squareColor)
                .frame(width: 36, height: 36)
                
            Text("\(dayNumber)")
                .font(.caption)
                .fontWeight(isToday ? .bold : .medium)
                .foregroundColor(textColor)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(isToday ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
        
    private var squareColor: Color {
        if isCompleted {
            return Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1))
        } else {
            return Color.gray.opacity(0.15)
        }
    }
        
    private var textColor: Color {
        isCompleted ? .white : .primary
    }
}

#Preview {
    DaySquare(
        date: Date(),
        isCompleted: true
    )
    .padding()
}
