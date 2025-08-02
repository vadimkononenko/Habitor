//
//  CalendarDayView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 02.08.2025.
//

import SwiftUI

struct CalendarDayView: View {
    
    // MARK: - Variables
    let day: Int
    let isCompleted: Bool
    
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(day > 0 ? .accent : .gray.opacity(0.5))
            .frame(width: 30, height: 30)
            .opacity(day > 0 && isCompleted ? 1.0 : 0.3)
            .overlay {
                Text("\(day)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(day > 0 ? 1.0 : 0.0)
            }
    }
}
