//
//  HabitDateView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct HabitDateView: View {
    // MARK: - Body
    var body: some View {
        Text(currentFormattedDate)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    // MARK: - Computed Properties
    private var currentFormattedDate: String {
        Date.now.formatted(date: .numeric, time: .omitted)
    }
}
