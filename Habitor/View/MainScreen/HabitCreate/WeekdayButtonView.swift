//
//  WeekdayButtonView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI

struct WeekdayButtonView: View {
    let day: (Int, String)
    let isSelected: Bool
    let action: () -> Void
        
    var body: some View {
        Button(action: action) {
            Text(day.1)
        }
        .frame(maxWidth: .infinity)
        .font(.system(size: 10, weight: isSelected ? .bold : .regular))
        .padding(6)
        .background(isSelected ? Color.accentColor : Color.gray.opacity(0.2))
        .foregroundColor(isSelected ? Color.white : Color.primary)
        .cornerRadius(5)
        .buttonStyle(.plain)
    }
}
