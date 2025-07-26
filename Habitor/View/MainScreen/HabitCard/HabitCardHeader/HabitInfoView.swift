//
//  HabitInfoView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct HabitInfoView: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text(habit.title ?? "Untitled")
                .font(.headline)
                .lineLimit(2)
            
            // Description
            if let description = habit.descriptionText,
               !description.isEmpty {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            // Categories
            if let categories = habit.categories,
               !categories.isEmpty {
                CategoriesScrollView(categories: Array(categories))
            }
        }
    }
}
